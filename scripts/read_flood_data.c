#include <stdio.h>
#include <stdlib.h>

/*
read_flood_data.c takes a .bin file containing raw data as input & converts it 
to a .txt file
*/

void readLayer(char *filename, float *buffer,int row, int col)
{
    int i,j;
    FILE *pfile;
    size_t size;
    if((pfile=fopen(filename, "rb"))==NULL)
    {
        printf("The thresholdfile is not available yet! %s \n", filename);
        exit(-1);
    }
    for (i=0;i<row;i++)
    {
        for (j=0;j<col;j++)
        {
            size=fread(&(buffer[i*col+j]),sizeof(float),1,pfile);
        }
    }
    fclose(pfile);
    return;
}

int main()
{
    char *file = "Flood_byStor_2021091203.bin";
    int row = 800;
    int col = 2458;
    float *buffer = (float*)malloc(row*col*sizeof(float));
    readLayer(file,buffer,row,col);
    
    for (int i=0; i<row*col; i++)
    {
        printf("%f\n", buffer[i]);
    }
}