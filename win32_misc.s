; these APIs should have been in SP4 or the post-SP4 hotfixes
; perhaps even backported to the post-SP6a package for NT4 (!)
; -despair
.686p
.mmx
.model flat

_text segment public 'CODE'
assume cs:_text
assume es:nothing, ss:nothing, ds:_data, fs:nothing, gs:nothing

; Yes, the undecorated form of this contains an extra underscore
; to avoid conflicting with translation units that are able to
; import the "real" API entry
public __RtlCaptureContext@4
__RtlCaptureContext@4 proc near

var_4= dword ptr -4
arg_0= dword ptr  4

push    ebx
mov     ebx, [esp+4+arg_0]
mov     [ebx+0B0h], eax
mov     [ebx+0ACh], ecx
mov     [ebx+0A8h], edx
mov     eax, [esp+4+var_4]
mov     [ebx+0A4h], eax
mov     [ebx+0A0h], esi
mov     [ebx+9Ch], edi
jmp     CaptureRest
__RtlCaptureContext@4 endp


public _RtlpCaptureContext@4
_RtlpCaptureContext@4 proc near

arg_0= dword ptr  4

push    ebx
mov     ebx, [esp+4+arg_0]
mov     dword ptr [ebx+0B0h], 0
mov     dword ptr [ebx+0ACh], 0
mov     dword ptr [ebx+0A8h], 0
mov     dword ptr [ebx+0A4h], 0
mov     dword ptr [ebx+0A0h], 0
mov     dword ptr [ebx+9Ch], 0
CaptureRest::
mov     word ptr [ebx+0BCh], cs
mov     word ptr [ebx+98h], ds
mov     word ptr [ebx+94h], es
mov     word ptr [ebx+90h], fs
mov     word ptr [ebx+8Ch], gs
mov     word ptr [ebx+0C8h], ss
pushf
pop     dword ptr [ebx+0C0h]
mov     eax, [ebp+4]
mov     [ebx+0B8h], eax
mov     eax, [ebp+0]
mov     [ebx+0B4h], eax
lea     eax, [ebp+8]
mov     [ebx+0C4h], eax
pop     ebx
retn    4
_RtlpCaptureContext@4 endp

_text ends
end
