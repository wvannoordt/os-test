#define VIDEO_MEMORY_ADDR 0xb8000
void main()
{
    const char* str = "What is up my boys welcome to ShitOS";
    char* vid_mem = (char*)VIDEO_MEMORY_ADDR;
    int c = 0;
    for (const char* i = str; *i!=0; i++)
    {
        *(vid_mem+2*c) = *(i);
        *(vid_mem+2*c+1) = 0x05;
        c++;
    }
}