import ctypes

def print_dll_contents(dll_path):
    try:
        # Load the DLL
        # NOTE: THE PYTHON ARCH VERSION SHOULD BE THE SAME AS THE COMPILED ONE (32 - 32 BITS)
        custom_dll = ctypes.cdll.LoadLibrary(dll_path)

        func = custom_dll.Add
        func.restype = ctypes.c_int
        func.argtypes = [ctypes.c_int, ctypes.c_int]

        print(" Result is: %s "%func(1,2))

    except Exception as e:
        print("Error:", e)

if __name__ == "__main__":
    dll_path = "F:\\Workspace\\Build_Dll\\Build\\_wrk\\add.dll"
    print_dll_contents(dll_path)
