from __future__ import unicode_literals
import csv
import pandas as pd

"""
assign_pixel_lat_long_and_match.py calls assign_cells to assign latitude & 
longitude values to each pixel in flood_data & returns a dictionary & csv file 
containing with the updated latitude/longitude & the corresponding amount of 
flooding for each pixel. match_flooding takes the dictionary as an input & 
matches each barangay's latitude/longitude coordinates from the 2013 Philippine 
DHS with their corresponding pixel in the dictionary, printing a list of the 
flooding each barangay experiences.
"""

# column names for csv output
lat_long_headers = ["amount_flooding_pix", "lat_low", "lat_up", "long_low", 
"long_up"]

def assign_cells():
    """
    assign_cells takes flood_data as an input file and returns a list of 
    dictionaries for each pixel. matched_lat_long.csv is an output file 
    containing all the list data. There are 5 key-value pairs for each pixel: 
    the amount of flooding, the upper & lower latitude value (lat_up & lat_low) 
    in decimal coordinate form, and the upper & lower longitude value (long_up 
    & long_low) in decimal coordinate form.
    """
    dict_list = []
    # flood_data is a 800 by 2458 .txt file with newline delimited floats. 
    #   These floats indicate the amount of flooding for each pixel, defined as 
    #   the depth in mm of the surface water above dry ground
    with open("txt files/flood_data_2013081215.txt") as input_file:
        values = input_file.read().split()
        # loops over each line in the .txt file (i.e., each pixel)
        for i in range(len(values)):
            # assign keys to each dictionary
            lat_long_dict = {key: None for key in lat_long_headers}
            lat_long_dict["amount_flooding_pix"] = float(values[i])
            # latitude values don't change if you're in the same row (2458 
            #   pixels long), decrease latitude once you reach a multiple of 
            #   2458
            lat_long_dict["lat_up"] = 50.00 - 0.125*(i//2458)
            lat_long_dict["lat_low"] = 49.865 - 0.125*(i//2458)
            # longitude increases within a row (2458 pixels long), once a 
            #   multiple of 2458 is reached, start over using the initial 
            #   longitude value 
            lat_long_dict["long_low"] = -127.25 + 0.125*(i%2458)
            lat_long_dict["long_up"] = -127.125 + 0.125*(i%2458)
            dict_list.append(lat_long_dict)
    
    # writes data from dict_list to a csv file 
    with open('matched_lat_long.csv', 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=lat_long_headers)
        writer.writeheader()
        writer.writerows(dict_list)
    
    return dict_list

def match_flooding(ref_list):
    """
    match_flooding takes ref_list, a list of dictionaries containing the amount 
    of flooding, the upper & lower latitude value (lat_up & lat_low), and the 
    upper & lower longitude value (long_up & long_low) for each pixel, & prints 
    a list with the amount of flooding each barangay experiences (after matching 
    each barangay's coordinates from the 2013 Philippine DHS file to their 
    corresponding pixel).
    """
    # convert list to a dataframe
    reference_df = pd.DataFrame(ref_list, columns=lat_long_headers)
    # only loop over pixels that are relevant to the regions of interest (with 
    #   generous leeway in upper/lower latitude/longitude boundaries)
    cropped_reference_df = reference_df.loc[(reference_df["lat_low"]>=11) \
        & (reference_df["lat_up"]<=19) & (reference_df["long_low"]>=119) \
        & (reference_df["long_up"]<=125), lat_long_headers]
    # resets the index after removing irrelevant pixels
    cropped_reference_df = cropped_reference_df.reset_index()
    # convert DHS .dta file to a dataframe
    data_df = pd.read_stata("cropped_DHS_2013.dta")
    amount_flooding = []
    # loop over every barangay
    for i in range(len(data_df)):
        # variables referring to the current barangay's latitude & longitude
        latitude = data_df.loc[i, "latitude_b"]
        longitude = data_df.loc[i, "longitude_b"]
        # loop over/check every pixel in the reference dataframe to find the  
        #   match to the current barangay
        for j in range(len(cropped_reference_df)):
            # variables referring to the upper/lower latitude/longitude bounds
            latitude_lower = cropped_reference_df.loc[j, "lat_low"]
            latitude_upper = cropped_reference_df.loc[j, "lat_up"]
            longitude_lower = cropped_reference_df.loc[j, "long_low"]
            longitude_upper = cropped_reference_df.loc[j, "long_up"]
            # check if the current barangay falls within the bounds
            if ((latitude >= latitude_lower) & (latitude <= latitude_upper) 
            & (longitude >= longitude_lower) & (longitude <= longitude_upper)):
                # append the amount of flooding at the barangay
                amount_flooding.append(cropped_reference_df.loc[j, 
                    "amount_flooding_pix"])
                # check the next barangay
                break
    # Stata file is incorrectly encoded
    #   data_df['amount_flooding'] = amount_flooding
    #   data_df.to_stata('matched_DHS_data.dta')
    print(amount_flooding)
    return

if __name__=='__main__':
    ref_list = assign_cells()
    match_flooding(ref_list)
