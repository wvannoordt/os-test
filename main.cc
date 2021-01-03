#include <iostream>
#include <vector>
#include <unistd.h>
#define PROG_SIZE 512

std::vector<char> bytes;
std::vector<int> indx;
void NewByte(char byteData, int idx)
{
    indx.push_back(idx);
    bytes.push_back(byteData);
}
int main(int argc, char** argv)
{
    char* program = (char*)malloc(PROG_SIZE*sizeof(char));
    for (int i = 0; i < PROG_SIZE; i++) program[i] = 0;
    NewByte(0xe9, 0);
    NewByte(0xfd, 1);
    NewByte(0xff, 2);
    NewByte(0x55, PROG_SIZE-2);
    NewByte(0xaa, PROG_SIZE-1);
    for (int i = 0; i < bytes.size(); i++)
    {
        program[indx[i]] = bytes[i];
    }
    FILE* ptr;
    ptr = fopen("boot_sect.bin","wb");
    fwrite(program, PROG_SIZE, sizeof(char), ptr);
    fclose(ptr);
    free(program);
    return 0;
}
