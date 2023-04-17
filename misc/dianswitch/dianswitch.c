/*
gcc -o dianswitch.exe dianswitch.c
*/

#include <windows.h>
#include <stdio.h>

BOOL CALLBACK enum_windows_callback(HWND hwnd, LPARAM lParam)
{
    if (!IsWindowVisible(hwnd) || !IsWindowEnabled(hwnd))
    {
        return TRUE;
    }
    char title[1024];
    if (GetWindowText(hwnd, title, sizeof(title)) > 0)
    {
        printf("%s\n", title);
    }
    return TRUE;
}

void switch_to_window(const char *title)
{
    HWND hwnd = FindWindow(NULL, title);
    if (hwnd == NULL)
    {
        printf("Window not found: %s\n", title);
        return;
    }
    SetForegroundWindow(hwnd);
}

int main(int argc, char *argv[])
{

    if (argc == 1)
    {
        EnumWindows(enum_windows_callback, 0);
    }
    else
    {
        switch_to_window(argv[1]);
    }
    return 0;
}
