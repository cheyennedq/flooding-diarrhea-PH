from PIL import Image
import numpy as np
import argparse

legend = {
  0: [100, 100, 100],     # black
  0.1: [252, 244, 163],   # light yellow (banana)
  10: [255, 211, 0],      # yellow
  20: [249, 166, 2],      # gold
  50: [101, 147, 245],    # light blue (cornflower)
  100: [0, 128, 255],     # cyan
  200: [0, 0, 128]        # navy
}

def get_pixel_color(pixel_value):
  returned_color = [0, 0, 0]
  if pixel_value == -9999.0:
    return returned_color
  for threshold, color in legend.items():
    if pixel_value > threshold:
      returned_color = color
  return returned_color
    

if __name__=='__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('width', type=int)
  parser.add_argument('height', type=int)
  parser.add_argument('-data_filepath', default="txt files/flood_data_2021091203.txt")
  args = parser.parse_args()

  width = args.width
  height = args.height
  with open(args.data_filepath) as input_file:
    # has 1966400 cells
    values = input_file.read().split()
    color_values = []
    for value in values:
      sanitized_value = float(value)
      color_values.append(get_pixel_color(sanitized_value))
    pixels = []
    for j in range(height):
      pixel_row = []
      for i in range(width):
        pixel_row.append(
          color_values[width*j + i]
        )
      pixels.append(pixel_row)

    pixels_np_array = np.array(pixels, dtype=np.uint8)
    original_image = Image.fromarray(pixels_np_array)
    original_image.save('2021091203_flood_map.png')

    transp_image = Image.open('2021091203_flood_map.png')
    rgba = transp_image.convert("RGBA")
    data = rgba.getdata()
      
    newData = []
    for item in data:
        if item[0] == 0 and item[1] == 0 and item[2] == 0:  # finding black color by its RGB value
            # storing a transparent value when we find a black color
            newData.append((255, 255, 255, 0))
        else:
            newData.append(item)  # other colors remain unchanged
      
    rgba.putdata(newData)
    rgba.save("2021091203_transparent_flood_map.png", "PNG")
