" OmniCppComplete initialization
call omni#cpp#complete#Init()
" Causes blocks of code to be folded - use z{ and z} to fold/unfold
syn region cBlockFold start="{" end="}" transparent fold
