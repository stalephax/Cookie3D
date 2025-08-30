
Module: D:\CODING\ENGINE\030697\wmain.c
Group: 'DGROUP' CONST,CONST2,_DATA,_BSS

Segment: _TEXT  BYTE USE32  00001583 bytes  
 0000  53                _VBE_fatalError push    ebx
 0001  56                                push    esi
 0002  57                                push    edi
 0003  55                                push    ebp
 0004  89 e5                             mov     ebp,esp
 0006  81 ec 00 00 00 00                 sub     esp,00000000H
 000c  8b 45 14                          mov     eax,+14H[ebp]
 000f  50                                push    eax
 0010  b8 00 00 00 00                    mov     eax,offset L82
 0015  50                                push    eax
 0016  b8 34 00 00 00                    mov     eax,offset ___iob+34H
 001b  50                                push    eax
 001c  e8 00 00 00 00                    call    fprintf_
 0021  83 c4 0c                          add     esp,0000000cH
 0024  b8 01 00 00 00                    mov     eax,00000001H
 0029  e8 00 00 00 00                    call    exit_
 002e  5d                                pop     ebp
 002f  5f                                pop     edi
 0030  5e                                pop     esi
 0031  5b                                pop     ebx
 0032  c3                                ret     
 0033                    getValidGraphicsMode_:
 0033  53                                push    ebx
 0034  51                                push    ecx
 0035  52                                push    edx
 0036  56                                push    esi
 0037  57                                push    edi
 0038  55                                push    ebp
 0039  89 e5                             mov     ebp,esp
 003b  81 ec 08 01 00 00                 sub     esp,00000108H
 0041  c7 45 f8 00 00 00 
       00                                mov     dword ptr -8H[ebp],offset _modeList
 0048  8b 45 f8          L1              mov     eax,-8H[ebp]
 004b  66 83 38 ff                       cmp     word ptr [eax],0ffffH
 004f  75 0b                             jne     L3
 0051  eb 3e                             jmp     L5
 0053  8b 45 f8          L2              mov     eax,-8H[ebp]
 0056  83 45 f8 02                       add     dword ptr -8H[ebp],00000002H
 005a  eb ec                             jmp     L1
 005c  8d 95 f8 fe ff ff L3              lea     edx,-108H[ebp]
 0062  8b 45 f8                          mov     eax,-8H[ebp]
 0065  66 8b 00                          mov     ax,[eax]
 0068  25 ff ff 00 00                    and     eax,0000ffffH
 006d  e8 00 00 00 00                    call    VBE_getModeInfo_
 0072  66 85 c0                          test    ax,ax
 0075  74 dc                             je      L2
 0077  66 f7 85 f8 fe ff 
       ff 10 00                          test    word ptr -108H[ebp],0010H
 0080  74 0d                             je      L4
 0082  31 c0                             xor     eax,eax
 0084  8b 55 f8                          mov     edx,-8H[ebp]
 0087  66 8b 02                          mov     ax,[edx]
 008a  89 45 fc                          mov     -4H[ebp],eax
 008d  eb 17                             jmp     L6
 008f  eb c2             L4              jmp     L2
 0091  b8 04 00 00 00    L5              mov     eax,offset L83
 0096  50                                push    eax
 0097  e8 00 00 00 00                    call    printf_
 009c  83 c4 04                          add     esp,00000004H
 009f  c7 45 fc ff ff ff 
       ff                                mov     dword ptr -4H[ebp],0ffffffffH
 00a6  8b 45 fc          L6              mov     eax,-4H[ebp]
 00a9  89 ec                             mov     esp,ebp
 00ab  5d                                pop     ebp
 00ac  5f                                pop     edi
 00ad  5e                                pop     esi
 00ae  5a                                pop     edx
 00af  59                                pop     ecx
 00b0  5b                                pop     ebx
 00b1  c3                                ret     
 00b2                    BSPtraverseTreeAndRender_:
 00b2  53                                push    ebx
 00b3  51                                push    ecx
 00b4  52                                push    edx
 00b5  56                                push    esi
 00b6  57                                push    edi
 00b7  55                                push    ebp
 00b8  89 e5                             mov     ebp,esp
 00ba  81 ec 04 00 00 00                 sub     esp,00000004H
 00c0  89 45 fc                          mov     -4H[ebp],eax
 00c3  83 7d fc 00                       cmp     dword ptr -4H[ebp],00000000H
 00c7  0f 84 97 00 00 00                 je      L8
 00cd  8b 45 fc                          mov     eax,-4H[ebp]
 00d0  80 38 70                          cmp     byte ptr [eax],70H
 00d3  0f 85 8b 00 00 00                 jne     L8
 00d9  ba 00 00 00 00                    mov     edx,offset _playerposition
 00de  8b 45 fc                          mov     eax,-4H[ebp]
 00e1  8b 40 01                          mov     eax,+1H[eax]
 00e4  8b 00                             mov     eax,[eax]
 00e6  05 84 00 00 00                    add     eax,00000084H
 00eb  e8 00 00 00 00                    call    BSPisViewerInPositiveSideOfPlane_
 00f0  85 c0                             test    eax,eax
 00f2  74 39                             je      L7
 00f4  8b 45 fc                          mov     eax,-4H[ebp]
 00f7  8b 40 01                          mov     eax,+1H[eax]
 00fa  8b 40 08                          mov     eax,+8H[eax]
 00fd  e8 00 00 00 00                    call    BSPtraverseTreeAndRender_
 0102  8b 45 fc                          mov     eax,-4H[ebp]
 0105  8b 40 01                          mov     eax,+1H[eax]
 0108  8b 00                             mov     eax,[eax]
 010a  e8 00 00 00 00                    call    drawFaceList_
 010f  8b 45 fc                          mov     eax,-4H[ebp]
 0112  8b 40 01                          mov     eax,+1H[eax]
 0115  8b 40 04                          mov     eax,+4H[eax]
 0118  e8 00 00 00 00                    call    drawFaceList_
 011d  8b 45 fc                          mov     eax,-4H[ebp]
 0120  8b 40 01                          mov     eax,+1H[eax]
 0123  8b 40 0c                          mov     eax,+0cH[eax]
 0126  e8 00 00 00 00                    call    BSPtraverseTreeAndRender_
 012b  eb 37                             jmp     L8
 012d  8b 45 fc          L7              mov     eax,-4H[ebp]
 0130  8b 40 01                          mov     eax,+1H[eax]
 0133  8b 40 0c                          mov     eax,+0cH[eax]
 0136  e8 00 00 00 00                    call    BSPtraverseTreeAndRender_
 013b  8b 45 fc                          mov     eax,-4H[ebp]
 013e  8b 40 01                          mov     eax,+1H[eax]
 0141  8b 40 04                          mov     eax,+4H[eax]
 0144  e8 00 00 00 00                    call    drawFaceList_
 0149  8b 45 fc                          mov     eax,-4H[ebp]
 014c  8b 40 01                          mov     eax,+1H[eax]
 014f  8b 00                             mov     eax,[eax]
 0151  e8 00 00 00 00                    call    drawFaceList_
 0156  8b 45 fc                          mov     eax,-4H[ebp]
 0159  8b 40 01                          mov     eax,+1H[eax]
 015c  8b 40 08                          mov     eax,+8H[eax]
 015f  e8 00 00 00 00                    call    BSPtraverseTreeAndRender_
 0164  89 ec             L8              mov     esp,ebp
 0166  5d                                pop     ebp
 0167  5f                                pop     edi
 0168  5e                                pop     esi
 0169  5a                                pop     edx
 016a  59                                pop     ecx
 016b  5b                                pop     ebx
 016c  c3                                ret     
 016d  51                getScene_       push    ecx
 016e  56                                push    esi
 016f  57                                push    edi
 0170  55                                push    ebp
 0171  89 e5                             mov     ebp,esp
 0173  81 ec 20 01 00 00                 sub     esp,00000120H
 0179  89 45 ac                          mov     -54H[ebp],eax
 017c  89 55 cc                          mov     -34H[ebp],edx
 017f  89 5d d0                          mov     -30H[ebp],ebx
 0182  c7 45 c4 00 00 00 
       00                                mov     dword ptr -3cH[ebp],00000000H
 0189  c7 45 c8 00 00 00 
       00                                mov     dword ptr -38H[ebp],00000000H
 0190  c7 45 d4 00 00 00 
       00                                mov     dword ptr -2cH[ebp],00000000H
 0197  c7 45 d8 00 00 00 
       00                                mov     dword ptr -28H[ebp],00000000H
 019e  c7 45 dc 00 00 00 
       00                                mov     dword ptr -24H[ebp],00000000H
 01a5  c7 45 e0 00 00 00 
       00                                mov     dword ptr -20H[ebp],00000000H
 01ac  ba 28 00 00 00                    mov     edx,offset L84
 01b1  8b 45 ac                          mov     eax,-54H[ebp]
 01b4  e8 00 00 00 00                    call    fopen_
 01b9  89 45 fc                          mov     -4H[ebp],eax
 01bc  83 7d fc 00                       cmp     dword ptr -4H[ebp],00000000H
 01c0  75 22                             jne     L9
 01c2  8b 45 ac                          mov     eax,-54H[ebp]
 01c5  50                                push    eax
 01c6  b8 2a 00 00 00                    mov     eax,offset L85
 01cb  50                                push    eax
 01cc  b8 34 00 00 00                    mov     eax,offset ___iob+34H
 01d1  50                                push    eax
 01d2  e8 00 00 00 00                    call    fprintf_
 01d7  83 c4 0c                          add     esp,0000000cH
 01da  b8 01 00 00 00                    mov     eax,00000001H
 01df  e8 00 00 00 00                    call    exit_
 01e4  8b 45 ac          L9              mov     eax,-54H[ebp]
 01e7  50                                push    eax
 01e8  b8 3f 00 00 00                    mov     eax,offset L86
 01ed  50                                push    eax
 01ee  e8 00 00 00 00                    call    printf_
 01f3  83 c4 08                          add     esp,00000008H
 01f6  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _startpos,00000000H
 0200  c7 05 04 00 00 00 
       00 00 00 00                       mov     dword ptr _startpos+4H,00000000H
 020a  c7 05 08 00 00 00 
       00 00 00 00                       mov     dword ptr _startpos+8H,00000000H
 0214  c7 45 98 00 00 00 
       00                                mov     dword ptr -68H[ebp],00000000H
 021b  c7 45 9c 00 00 00 
       00                                mov     dword ptr -64H[ebp],00000000H
 0222  c7 45 a0 00 00 00 
       00                                mov     dword ptr -60H[ebp],00000000H
 0229  8b 45 cc                          mov     eax,-34H[ebp]
 022c  c7 00 00 00 00 00                 mov     dword ptr [eax],00000000H
 0232  8b 45 cc                          mov     eax,-34H[ebp]
 0235  c7 40 04 00 00 00 
       00                                mov     dword ptr +4H[eax],00000000H
 023c  8b 45 cc                          mov     eax,-34H[ebp]
 023f  c7 40 08 00 00 00 
       00                                mov     dword ptr +8H[eax],00000000H
 0246  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _NumberOfObjects,00000000H
 0250  c7 45 f4 00 00 00 
       00                                mov     dword ptr -0cH[ebp],00000000H
 0257  8b 45 d0                          mov     eax,-30H[ebp]
 025a  c7 00 00 00 00 00                 mov     dword ptr [eax],00000000H
 0260  c7 45 c0 00 00 00 
       00                                mov     dword ptr -40H[ebp],00000000H
 0267  c7 45 b0 00 00 00 
       00                                mov     dword ptr -50H[ebp],offset _pcxtextures
 026e  ba 00 00 01 00                    mov     edx,00010000H
 0273  8b 45 b0                          mov     eax,-50H[ebp]
 0276  8d b5 20 ff ff ff                 lea     esi,-0e0H[ebp]
 027c  e8 00 00 00 00                    call    div_
 0281  8d 7d a4                          lea     edi,-5cH[ebp]
 0284  8d b5 20 ff ff ff                 lea     esi,-0e0H[ebp]
 028a  a5                                movsd   
 028b  a5                                movsd   
 028c  8b 45 a4                          mov     eax,-5cH[ebp]
 028f  40                                inc     eax
 0290  c1 e0 10                          shl     eax,10H
 0293  a3 00 00 00 00                    mov     _texturestart,eax
 0298  c7 45 f0 00 00 00 
       00                                mov     dword ptr -10H[ebp],00000000H
 029f  c7 05 00 00 00 00 
       ff ff ff ff                       mov     dword ptr _linenumber,0ffffffffH
 02a9  8b 5d fc          L10             mov     ebx,-4H[ebp]
 02ac  ba 50 00 00 00                    mov     edx,00000050H
 02b1  b8 c0 01 14 00                    mov     eax,offset L140
 02b6  e8 00 00 00 00                    call    fgets_
 02bb  85 c0                             test    eax,eax
 02bd  0f 84 5c 06 00 00                 je      L29
 02c3  ff 05 00 00 00 00                 inc     dword ptr _linenumber
 02c9  80 3d c0 01 14 00 
       50                                cmp     byte ptr L140,50H
 02d0  0f 85 e9 00 00 00                 jne     L12
 02d6  83 7d d4 00                       cmp     dword ptr -2cH[ebp],00000000H
 02da  0f 84 b5 00 00 00                 je      L11
 02e0  8b 45 d4                          mov     eax,-2cH[ebp]
 02e3  ff 70 10                          push    +10H[eax]
 02e6  8b 45 d4                          mov     eax,-2cH[ebp]
 02e9  ff 70 0c                          push    +0cH[eax]
 02ec  8b 45 d4                          mov     eax,-2cH[ebp]
 02ef  ff 70 08                          push    +8H[eax]
 02f2  8b 45 d4                          mov     eax,-2cH[ebp]
 02f5  ff 70 04                          push    +4H[eax]
 02f8  8b 45 d4                          mov     eax,-2cH[ebp]
 02fb  ff 30                             push    [eax]
 02fd  e8 00 00 00 00                    call    allocVertex_
 0302  89 c3                             mov     ebx,eax
 0304  8d 55 d8                          lea     edx,-28H[ebp]
 0307  8d 45 d4                          lea     eax,-2cH[ebp]
 030a  e8 00 00 00 00                    call    appendVertex_
 030f  8d 45 88                          lea     eax,-78H[ebp]
 0312  50                                push    eax
 0313  8b 45 d4                          mov     eax,-2cH[ebp]
 0316  8b 40 14                          mov     eax,+14H[eax]
 0319  8b 40 14                          mov     eax,+14H[eax]
 031c  ff 70 08                          push    +8H[eax]
 031f  8b 45 d4                          mov     eax,-2cH[ebp]
 0322  8b 40 14                          mov     eax,+14H[eax]
 0325  8b 40 14                          mov     eax,+14H[eax]
 0328  ff 70 04                          push    +4H[eax]
 032b  8b 45 d4                          mov     eax,-2cH[ebp]
 032e  8b 40 14                          mov     eax,+14H[eax]
 0331  8b 40 14                          mov     eax,+14H[eax]
 0334  ff 30                             push    [eax]
 0336  8b 45 d4                          mov     eax,-2cH[ebp]
 0339  8b 40 14                          mov     eax,+14H[eax]
 033c  ff 70 08                          push    +8H[eax]
 033f  8b 45 d4                          mov     eax,-2cH[ebp]
 0342  8b 40 14                          mov     eax,+14H[eax]
 0345  ff 70 04                          push    +4H[eax]
 0348  8b 45 d4                          mov     eax,-2cH[ebp]
 034b  8b 40 14                          mov     eax,+14H[eax]
 034e  ff 30                             push    [eax]
 0350  8b 45 d4                          mov     eax,-2cH[ebp]
 0353  ff 70 08                          push    +8H[eax]
 0356  8b 45 d4                          mov     eax,-2cH[ebp]
 0359  ff 70 04                          push    +4H[eax]
 035c  8b 45 d4                          mov     eax,-2cH[ebp]
 035f  ff 30                             push    [eax]
 0361  e8 00 00 00 00                    call    computePlane_
 0366  8d 45 88                          lea     eax,-78H[ebp]
 0369  50                                push    eax
 036a  8b 45 d4                          mov     eax,-2cH[ebp]
 036d  50                                push    eax
 036e  8d 4d e4                          lea     ecx,-1cH[ebp]
 0371  8d 9d 50 ff ff ff                 lea     ebx,-0b0H[ebp]
 0377  8d 95 50 ff ff ff                 lea     edx,-0b0H[ebp]
 037d  8d 85 50 ff ff ff                 lea     eax,-0b0H[ebp]
 0383  e8 00 00 00 00                    call    allocFace_
 0388  89 c3                             mov     ebx,eax
 038a  8d 55 c4                          lea     edx,-3cH[ebp]
 038d  8b 45 d0                          mov     eax,-30H[ebp]
 0390  e8 00 00 00 00                    call    appendFace_
 0395  8d 45 e4          L11             lea     eax,-1cH[ebp]
 0398  50                                push    eax
 0399  b8 49 00 00 00                    mov     eax,offset L87
 039e  50                                push    eax
 039f  b8 c0 01 14 00                    mov     eax,offset L140
 03a4  50                                push    eax
 03a5  e8 00 00 00 00                    call    sscanf_
 03aa  83 c4 0c                          add     esp,0000000cH
 03ad  c7 45 d8 00 00 00 
       00                                mov     dword ptr -28H[ebp],00000000H
 03b4  8b 45 d8                          mov     eax,-28H[ebp]
 03b7  89 45 d4                          mov     -2cH[ebp],eax
 03ba  e9 5b 05 00 00                    jmp     L28
 03bf  80 3d c0 01 14 00 
       56                L12             cmp     byte ptr L140,56H
 03c6  0f 85 9e 00 00 00                 jne     L13
 03cc  8d 85 1c ff ff ff                 lea     eax,-0e4H[ebp]
 03d2  50                                push    eax
 03d3  8d 85 18 ff ff ff                 lea     eax,-0e8H[ebp]
 03d9  50                                push    eax
 03da  8d 85 14 ff ff ff                 lea     eax,-0ecH[ebp]
 03e0  50                                push    eax
 03e1  8d 85 10 ff ff ff                 lea     eax,-0f0H[ebp]
 03e7  50                                push    eax
 03e8  8d 85 0c ff ff ff                 lea     eax,-0f4H[ebp]
 03ee  50                                push    eax
 03ef  b8 51 00 00 00                    mov     eax,offset L88
 03f4  50                                push    eax
 03f5  b8 c0 01 14 00                    mov     eax,offset L140
 03fa  50                                push    eax
 03fb  e8 00 00 00 00                    call    sscanf_
 0400  83 c4 1c                          add     esp,0000001cH
 0403  c7 85 18 ff ff ff 
       00 00 00 00                       mov     dword ptr -0e8H[ebp],00000000H
 040d  c7 85 1c ff ff ff 
       00 00 00 00                       mov     dword ptr -0e4H[ebp],00000000H
 0417  d9 85 1c ff ff ff                 fld     dword ptr -0e4H[ebp]
 041d  83 ec 04                          sub     esp,00000004H
 0420  d9 1c 24                          fstp    dword ptr [esp]
 0423  d9 85 18 ff ff ff                 fld     dword ptr -0e8H[ebp]
 0429  83 ec 04                          sub     esp,00000004H
 042c  d9 1c 24                          fstp    dword ptr [esp]
 042f  d9 85 14 ff ff ff                 fld     dword ptr -0ecH[ebp]
 0435  83 ec 04                          sub     esp,00000004H
 0438  d9 1c 24                          fstp    dword ptr [esp]
 043b  d9 85 10 ff ff ff                 fld     dword ptr -0f0H[ebp]
 0441  83 ec 04                          sub     esp,00000004H
 0444  d9 1c 24                          fstp    dword ptr [esp]
 0447  d9 85 0c ff ff ff                 fld     dword ptr -0f4H[ebp]
 044d  83 ec 04                          sub     esp,00000004H
 0450  d9 1c 24                          fstp    dword ptr [esp]
 0453  e8 00 00 00 00                    call    allocVertex_
 0458  89 c3                             mov     ebx,eax
 045a  8d 55 d8                          lea     edx,-28H[ebp]
 045d  8d 45 d4                          lea     eax,-2cH[ebp]
 0460  e8 00 00 00 00                    call    appendVertex_
 0465  e9 b0 04 00 00                    jmp     L28
 046a  80 3d c0 01 14 00 
       53                L13             cmp     byte ptr L140,53H
 0471  75 4f                             jne     L14
 0473  8d 85 08 ff ff ff                 lea     eax,-0f8H[ebp]
 0479  50                                push    eax
 047a  8d 85 04 ff ff ff                 lea     eax,-0fcH[ebp]
 0480  50                                push    eax
 0481  8d 85 00 ff ff ff                 lea     eax,-100H[ebp]
 0487  50                                push    eax
 0488  b8 51 00 00 00                    mov     eax,offset L88
 048d  50                                push    eax
 048e  b8 c0 01 14 00                    mov     eax,offset L140
 0493  50                                push    eax
 0494  e8 00 00 00 00                    call    sscanf_
 0499  83 c4 14                          add     esp,00000014H
 049c  8b 85 00 ff ff ff                 mov     eax,-100H[ebp]
 04a2  a3 00 00 00 00                    mov     _startpos,eax
 04a7  8b 85 08 ff ff ff                 mov     eax,-0f8H[ebp]
 04ad  a3 04 00 00 00                    mov     _startpos+4H,eax
 04b2  8b 85 04 ff ff ff                 mov     eax,-0fcH[ebp]
 04b8  a3 08 00 00 00                    mov     _startpos+8H,eax
 04bd  e9 58 04 00 00                    jmp     L28
 04c2  80 3d c0 01 14 00 
       4d                L14             cmp     byte ptr L140,4dH
 04c9  0f 85 8a 00 00 00                 jne     L15
 04cf  8d 85 fc fe ff ff                 lea     eax,-104H[ebp]
 04d5  50                                push    eax
 04d6  8d 85 f8 fe ff ff                 lea     eax,-108H[ebp]
 04dc  50                                push    eax
 04dd  8d 85 f4 fe ff ff                 lea     eax,-10cH[ebp]
 04e3  50                                push    eax
 04e4  8d 85 f0 fe ff ff                 lea     eax,-110H[ebp]
 04ea  50                                push    eax
 04eb  8d 85 ec fe ff ff                 lea     eax,-114H[ebp]
 04f1  50                                push    eax
 04f2  b8 51 00 00 00                    mov     eax,offset L88
 04f7  50                                push    eax
 04f8  b8 c0 01 14 00                    mov     eax,offset L140
 04fd  50                                push    eax
 04fe  e8 00 00 00 00                    call    sscanf_
 0503  83 c4 1c                          add     esp,0000001cH
 0506  d9 85 fc fe ff ff                 fld     dword ptr -104H[ebp]
 050c  83 ec 04                          sub     esp,00000004H
 050f  d9 1c 24                          fstp    dword ptr [esp]
 0512  d9 85 f8 fe ff ff                 fld     dword ptr -108H[ebp]
 0518  83 ec 04                          sub     esp,00000004H
 051b  d9 1c 24                          fstp    dword ptr [esp]
 051e  d9 85 f4 fe ff ff                 fld     dword ptr -10cH[ebp]
 0524  83 ec 04                          sub     esp,00000004H
 0527  d9 1c 24                          fstp    dword ptr [esp]
 052a  d9 85 f0 fe ff ff                 fld     dword ptr -110H[ebp]
 0530  83 ec 04                          sub     esp,00000004H
 0533  d9 1c 24                          fstp    dword ptr [esp]
 0536  d9 85 ec fe ff ff                 fld     dword ptr -114H[ebp]
 053c  83 ec 04                          sub     esp,00000004H
 053f  d9 1c 24                          fstp    dword ptr [esp]
 0542  e8 00 00 00 00                    call    allocVertex_
 0547  89 c3                             mov     ebx,eax
 0549  8d 55 e0                          lea     edx,-20H[ebp]
 054c  8d 45 dc                          lea     eax,-24H[ebp]
 054f  e8 00 00 00 00                    call    appendVertex_
 0554  e9 c1 03 00 00                    jmp     L28
 0559  80 3d c0 01 14 00 
       54                L15             cmp     byte ptr L140,54H
 0560  0f 85 1a 01 00 00                 jne     L20
 0566  ff 35 00 00 00 00                 push    _fname
 056c  b8 64 00 00 00                    mov     eax,offset L89
 0571  50                                push    eax
 0572  b8 c0 01 14 00                    mov     eax,offset L140
 0577  50                                push    eax
 0578  e8 00 00 00 00                    call    sscanf_
 057d  83 c4 0c                          add     esp,0000000cH
 0580  ba 6b 00 00 00                    mov     edx,offset L90
 0585  a1 00 00 00 00                    mov     eax,_fname
 058a  e8 00 00 00 00                    call    fopen_
 058f  89 45 b4                          mov     -4cH[ebp],eax
 0592  83 7d b4 00                       cmp     dword ptr -4cH[ebp],00000000H
 0596  75 21                             jne     L16
 0598  ff 35 00 00 00 00                 push    _linenumber
 059e  ff 35 00 00 00 00                 push    _fname
 05a4  b8 6e 00 00 00                    mov     eax,offset L91
 05a9  50                                push    eax
 05aa  e8 00 00 00 00                    call    printf_
 05af  83 c4 0c                          add     esp,0000000cH
 05b2  31 c0                             xor     eax,eax
 05b4  e8 00 00 00 00                    call    exit_
 05b9  8b 4d b4          L16             mov     ecx,-4cH[ebp]
 05bc  bb 01 00 00 00                    mov     ebx,00000001H
 05c1  ba 80 00 00 00                    mov     edx,00000080H
 05c6  b8 00 00 00 00                    mov     eax,offset _Header
 05cb  e8 00 00 00 00                    call    fread_
 05d0  8b 15 06 00 00 00                 mov     edx,_Header+6H
 05d6  c1 fa 10                          sar     edx,10H
 05d9  a1 02 00 00 00                    mov     eax,_Header+2H
 05de  c1 f8 10                          sar     eax,10H
 05e1  29 c2                             sub     edx,eax
 05e3  42                                inc     edx
 05e4  89 55 bc                          mov     -44H[ebp],edx
 05e7  8b 15 08 00 00 00                 mov     edx,_Header+8H
 05ed  c1 fa 10                          sar     edx,10H
 05f0  a1 04 00 00 00                    mov     eax,_Header+4H
 05f5  c1 f8 10                          sar     eax,10H
 05f8  29 c2                             sub     edx,eax
 05fa  42                                inc     edx
 05fb  89 55 e8                          mov     -18H[ebp],edx
 05fe  81 7d bc 00 01 00 
       00                                cmp     dword ptr -44H[ebp],00000100H
 0605  75 09                             jne     L17
 0607  81 7d e8 00 01 00 
       00                                cmp     dword ptr -18H[ebp],00000100H
 060e  74 1b                             je      L18
 0610  ff 35 00 00 00 00 L17             push    _fname
 0616  b8 8e 00 00 00                    mov     eax,offset L92
 061b  50                                push    eax
 061c  e8 00 00 00 00                    call    printf_
 0621  83 c4 08                          add     esp,00000008H
 0624  31 c0                             xor     eax,eax
 0626  e8 00 00 00 00                    call    exit_
 062b  a1 00 00 00 00    L18             mov     eax,_texturestart
 0630  89 45 b8                          mov     -48H[ebp],eax
 0633  8b 45 f0                          mov     eax,-10H[ebp]
 0636  c1 e0 10                          shl     eax,10H
 0639  01 45 b8                          add     -48H[ebp],eax
 063c  8b 4d e8                          mov     ecx,-18H[ebp]
 063f  8b 5d bc                          mov     ebx,-44H[ebp]
 0642  8b 55 b8                          mov     edx,-48H[ebp]
 0645  8b 45 b4                          mov     eax,-4cH[ebp]
 0648  e8 00 00 00 00                    call    UnpackPCX_
 064d  8b 45 b4                          mov     eax,-4cH[ebp]
 0650  e8 00 00 00 00                    call    fclose_
 0655  8b 45 f0                          mov     eax,-10H[ebp]
 0658  ff 45 f0                          inc     dword ptr -10H[ebp]
 065b  83 7d f0 13                       cmp     dword ptr -10H[ebp],00000013H
 065f  7e 1a                             jle     L19
 0661  6a 14                             push    00000014H
 0663  b8 b0 00 00 00                    mov     eax,offset L93
 0668  50                                push    eax
 0669  e8 00 00 00 00                    call    printf_
 066e  83 c4 08                          add     esp,00000008H
 0671  b8 ff ff ff ff                    mov     eax,0ffffffffH
 0676  e8 00 00 00 00                    call    exit_
 067b  e9 9a 02 00 00    L19             jmp     L28
 0680  80 3d c0 01 14 00 
       4f                L20             cmp     byte ptr L140,4fH
 0687  0f 85 6f 01 00 00                 jne     L25
 068d  83 3d 00 00 00 00 
       04                                cmp     dword ptr _NumberOfObjects,00000004H
 0694  7c 1a                             jl      L21
 0696  6a 04                             push    00000004H
 0698  b8 e2 00 00 00                    mov     eax,offset L94
 069d  50                                push    eax
 069e  e8 00 00 00 00                    call    printf_
 06a3  83 c4 08                          add     esp,00000008H
 06a6  b8 ff ff ff ff                    mov     eax,0ffffffffH
 06ab  e8 00 00 00 00                    call    exit_
 06b0  83 7d dc 00       L21             cmp     dword ptr -24H[ebp],00000000H
 06b4  0f 84 12 01 00 00                 je      L24
 06ba  8b 45 dc                          mov     eax,-24H[ebp]
 06bd  ff 70 10                          push    +10H[eax]
 06c0  8b 45 dc                          mov     eax,-24H[ebp]
 06c3  ff 70 0c                          push    +0cH[eax]
 06c6  8b 45 dc                          mov     eax,-24H[ebp]
 06c9  ff 70 08                          push    +8H[eax]
 06cc  8b 45 dc                          mov     eax,-24H[ebp]
 06cf  ff 70 04                          push    +4H[eax]
 06d2  8b 45 dc                          mov     eax,-24H[ebp]
 06d5  ff 30                             push    [eax]
 06d7  e8 00 00 00 00                    call    allocVertex_
 06dc  89 c3                             mov     ebx,eax
 06de  8d 55 e0                          lea     edx,-20H[ebp]
 06e1  8d 45 dc                          lea     eax,-24H[ebp]
 06e4  e8 00 00 00 00                    call    appendVertex_
 06e9  8d 85 78 ff ff ff                 lea     eax,-88H[ebp]
 06ef  50                                push    eax
 06f0  8b 45 dc                          mov     eax,-24H[ebp]
 06f3  8b 40 14                          mov     eax,+14H[eax]
 06f6  8b 40 14                          mov     eax,+14H[eax]
 06f9  ff 70 08                          push    +8H[eax]
 06fc  8b 45 dc                          mov     eax,-24H[ebp]
 06ff  8b 40 14                          mov     eax,+14H[eax]
 0702  8b 40 14                          mov     eax,+14H[eax]
 0705  ff 70 04                          push    +4H[eax]
 0708  8b 45 dc                          mov     eax,-24H[ebp]
 070b  8b 40 14                          mov     eax,+14H[eax]
 070e  8b 40 14                          mov     eax,+14H[eax]
 0711  ff 30                             push    [eax]
 0713  8b 45 dc                          mov     eax,-24H[ebp]
 0716  8b 40 14                          mov     eax,+14H[eax]
 0719  ff 70 08                          push    +8H[eax]
 071c  8b 45 dc                          mov     eax,-24H[ebp]
 071f  8b 40 14                          mov     eax,+14H[eax]
 0722  ff 70 04                          push    +4H[eax]
 0725  8b 45 dc                          mov     eax,-24H[ebp]
 0728  8b 40 14                          mov     eax,+14H[eax]
 072b  ff 30                             push    [eax]
 072d  8b 45 dc                          mov     eax,-24H[ebp]
 0730  ff 70 08                          push    +8H[eax]
 0733  8b 45 dc                          mov     eax,-24H[ebp]
 0736  ff 70 04                          push    +4H[eax]
 0739  8b 45 dc                          mov     eax,-24H[ebp]
 073c  ff 30                             push    [eax]
 073e  e8 00 00 00 00                    call    computePlane_
 0743  8d 85 78 ff ff ff                 lea     eax,-88H[ebp]
 0749  50                                push    eax
 074a  8b 45 dc                          mov     eax,-24H[ebp]
 074d  50                                push    eax
 074e  8d 4d ec                          lea     ecx,-14H[ebp]
 0751  8d 9d 28 ff ff ff                 lea     ebx,-0d8H[ebp]
 0757  8d 95 28 ff ff ff                 lea     edx,-0d8H[ebp]
 075d  8d 85 28 ff ff ff                 lea     eax,-0d8H[ebp]
 0763  e8 00 00 00 00                    call    allocmovingFace_
 0768  89 c3                             mov     ebx,eax
 076a  8d 55 c8                          lea     edx,-38H[ebp]
 076d  8d 45 c0                          lea     eax,-40H[ebp]
 0770  e8 00 00 00 00                    call    appendFace_
 0775  83 7d f4 00                       cmp     dword ptr -0cH[ebp],00000000H
 0779  75 20                             jne     L22
 077b  ff 35 00 00 00 00                 push    _linenumber
 0781  b8 14 01 00 00                    mov     eax,offset L95
 0786  50                                push    eax
 0787  e8 00 00 00 00                    call    printf_
 078c  83 c4 08                          add     esp,00000008H
 078f  b8 ff ff ff ff                    mov     eax,0ffffffffH
 0794  e8 00 00 00 00                    call    exit_
 0799  eb 2b                             jmp     L23
 079b  8b 45 f8          L22             mov     eax,-8H[ebp]
 079e  50                                push    eax
 079f  8b 45 c0                          mov     eax,-40H[ebp]
 07a2  50                                push    eax
 07a3  8d bd e0 fe ff ff                 lea     edi,-120H[ebp]
 07a9  8d 75 98                          lea     esi,-68H[ebp]
 07ac  a5                                movsd   
 07ad  a5                                movsd   
 07ae  a5                                movsd   
 07af  ff b5 e8 fe ff ff                 push    -118H[ebp]
 07b5  ff b5 e4 fe ff ff                 push    -11cH[ebp]
 07bb  ff b5 e0 fe ff ff                 push    -120H[ebp]
 07c1  e8 00 00 00 00                    call    AddObject_
 07c6  ff 05 00 00 00 00 L23             inc     dword ptr _NumberOfObjects
 07cc  8b 45 f4          L24             mov     eax,-0cH[ebp]
 07cf  ff 45 f4                          inc     dword ptr -0cH[ebp]
 07d2  8d 45 f8                          lea     eax,-8H[ebp]
 07d5  50                                push    eax
 07d6  b8 55 01 00 00                    mov     eax,offset L96
 07db  50                                push    eax
 07dc  b8 c0 01 14 00                    mov     eax,offset L140
 07e1  50                                push    eax
 07e2  e8 00 00 00 00                    call    sscanf_
 07e7  83 c4 0c                          add     esp,0000000cH
 07ea  c7 45 e0 00 00 00 
       00                                mov     dword ptr -20H[ebp],00000000H
 07f1  8b 45 e0                          mov     eax,-20H[ebp]
 07f4  89 45 dc                          mov     -24H[ebp],eax
 07f7  e9 1e 01 00 00                    jmp     L28
 07fc  80 3d c0 01 14 00 
       51                L25             cmp     byte ptr L140,51H
 0803  0f 85 ec 00 00 00                 jne     L27
 0809  83 7d dc 00                       cmp     dword ptr -24H[ebp],00000000H
 080d  0f 84 bb 00 00 00                 je      L26
 0813  8b 45 dc                          mov     eax,-24H[ebp]
 0816  ff 70 10                          push    +10H[eax]
 0819  8b 45 dc                          mov     eax,-24H[ebp]
 081c  ff 70 0c                          push    +0cH[eax]
 081f  8b 45 dc                          mov     eax,-24H[ebp]
 0822  ff 70 08                          push    +8H[eax]
 0825  8b 45 dc                          mov     eax,-24H[ebp]
 0828  ff 70 04                          push    +4H[eax]
 082b  8b 45 dc                          mov     eax,-24H[ebp]
 082e  ff 30                             push    [eax]
 0830  e8 00 00 00 00                    call    allocVertex_
 0835  89 c3                             mov     ebx,eax
 0837  8d 55 e0                          lea     edx,-20H[ebp]
 083a  8d 45 dc                          lea     eax,-24H[ebp]
 083d  e8 00 00 00 00                    call    appendVertex_
 0842  8d 85 78 ff ff ff                 lea     eax,-88H[ebp]
 0848  50                                push    eax
 0849  8b 45 dc                          mov     eax,-24H[ebp]
 084c  8b 40 14                          mov     eax,+14H[eax]
 084f  8b 40 14                          mov     eax,+14H[eax]
 0852  ff 70 08                          push    +8H[eax]
 0855  8b 45 dc                          mov     eax,-24H[ebp]
 0858  8b 40 14                          mov     eax,+14H[eax]
 085b  8b 40 14                          mov     eax,+14H[eax]
 085e  ff 70 04                          push    +4H[eax]
 0861  8b 45 dc                          mov     eax,-24H[ebp]
 0864  8b 40 14                          mov     eax,+14H[eax]
 0867  8b 40 14                          mov     eax,+14H[eax]
 086a  ff 30                             push    [eax]
 086c  8b 45 dc                          mov     eax,-24H[ebp]
 086f  8b 40 14                          mov     eax,+14H[eax]
 0872  ff 70 08                          push    +8H[eax]
 0875  8b 45 dc                          mov     eax,-24H[ebp]
 0878  8b 40 14                          mov     eax,+14H[eax]
 087b  ff 70 04                          push    +4H[eax]
 087e  8b 45 dc                          mov     eax,-24H[ebp]
 0881  8b 40 14                          mov     eax,+14H[eax]
 0884  ff 30                             push    [eax]
 0886  8b 45 dc                          mov     eax,-24H[ebp]
 0889  ff 70 08                          push    +8H[eax]
 088c  8b 45 dc                          mov     eax,-24H[ebp]
 088f  ff 70 04                          push    +4H[eax]
 0892  8b 45 dc                          mov     eax,-24H[ebp]
 0895  ff 30                             push    [eax]
 0897  e8 00 00 00 00                    call    computePlane_
 089c  8d 85 78 ff ff ff                 lea     eax,-88H[ebp]
 08a2  50                                push    eax
 08a3  8b 45 dc                          mov     eax,-24H[ebp]
 08a6  50                                push    eax
 08a7  8d 4d ec                          lea     ecx,-14H[ebp]
 08aa  8d 9d 28 ff ff ff                 lea     ebx,-0d8H[ebp]
 08b0  8d 95 28 ff ff ff                 lea     edx,-0d8H[ebp]
 08b6  8d 85 28 ff ff ff                 lea     eax,-0d8H[ebp]
 08bc  e8 00 00 00 00                    call    allocmovingFace_
 08c1  89 c3                             mov     ebx,eax
 08c3  8d 55 c8                          lea     edx,-38H[ebp]
 08c6  8d 45 c0                          lea     eax,-40H[ebp]
 08c9  e8 00 00 00 00                    call    appendFace_
 08ce  8d 45 ec          L26             lea     eax,-14H[ebp]
 08d1  50                                push    eax
 08d2  b8 49 00 00 00                    mov     eax,offset L87
 08d7  50                                push    eax
 08d8  b8 c0 01 14 00                    mov     eax,offset L140
 08dd  50                                push    eax
 08de  e8 00 00 00 00                    call    sscanf_
 08e3  83 c4 0c                          add     esp,0000000cH
 08e6  c7 45 e0 00 00 00 
       00                                mov     dword ptr -20H[ebp],00000000H
 08ed  8b 45 e0                          mov     eax,-20H[ebp]
 08f0  89 45 dc                          mov     -24H[ebp],eax
 08f3  eb 25                             jmp     L28
 08f5  80 3d c0 01 14 00 
       2f                L27             cmp     byte ptr L140,2fH
 08fc  74 1c                             je      L28
 08fe  31 c0                             xor     eax,eax
 0900  a0 c0 01 14 00                    mov     al,L140
 0905  50                                push    eax
 0906  b8 60 01 00 00                    mov     eax,offset L97
 090b  50                                push    eax
 090c  b8 34 00 00 00                    mov     eax,offset ___iob+34H
 0911  50                                push    eax
 0912  e8 00 00 00 00                    call    fprintf_
 0917  83 c4 0c                          add     esp,0000000cH
 091a  e9 8a f9 ff ff    L28             jmp     L10
 091f  83 7d d4 00       L29             cmp     dword ptr -2cH[ebp],00000000H
 0923  0f 84 b5 00 00 00                 je      L30
 0929  8b 45 d4                          mov     eax,-2cH[ebp]
 092c  ff 70 10                          push    +10H[eax]
 092f  8b 45 d4                          mov     eax,-2cH[ebp]
 0932  ff 70 0c                          push    +0cH[eax]
 0935  8b 45 d4                          mov     eax,-2cH[ebp]
 0938  ff 70 08                          push    +8H[eax]
 093b  8b 45 d4                          mov     eax,-2cH[ebp]
 093e  ff 70 04                          push    +4H[eax]
 0941  8b 45 d4                          mov     eax,-2cH[ebp]
 0944  ff 30                             push    [eax]
 0946  e8 00 00 00 00                    call    allocVertex_
 094b  89 c3                             mov     ebx,eax
 094d  8d 55 d8                          lea     edx,-28H[ebp]
 0950  8d 45 d4                          lea     eax,-2cH[ebp]
 0953  e8 00 00 00 00                    call    appendVertex_
 0958  8d 45 88                          lea     eax,-78H[ebp]
 095b  50                                push    eax
 095c  8b 45 d4                          mov     eax,-2cH[ebp]
 095f  8b 40 14                          mov     eax,+14H[eax]
 0962  8b 40 14                          mov     eax,+14H[eax]
 0965  ff 70 08                          push    +8H[eax]
 0968  8b 45 d4                          mov     eax,-2cH[ebp]
 096b  8b 40 14                          mov     eax,+14H[eax]
 096e  8b 40 14                          mov     eax,+14H[eax]
 0971  ff 70 04                          push    +4H[eax]
 0974  8b 45 d4                          mov     eax,-2cH[ebp]
 0977  8b 40 14                          mov     eax,+14H[eax]
 097a  8b 40 14                          mov     eax,+14H[eax]
 097d  ff 30                             push    [eax]
 097f  8b 45 d4                          mov     eax,-2cH[ebp]
 0982  8b 40 14                          mov     eax,+14H[eax]
 0985  ff 70 08                          push    +8H[eax]
 0988  8b 45 d4                          mov     eax,-2cH[ebp]
 098b  8b 40 14                          mov     eax,+14H[eax]
 098e  ff 70 04                          push    +4H[eax]
 0991  8b 45 d4                          mov     eax,-2cH[ebp]
 0994  8b 40 14                          mov     eax,+14H[eax]
 0997  ff 30                             push    [eax]
 0999  8b 45 d4                          mov     eax,-2cH[ebp]
 099c  ff 70 08                          push    +8H[eax]
 099f  8b 45 d4                          mov     eax,-2cH[ebp]
 09a2  ff 70 04                          push    +4H[eax]
 09a5  8b 45 d4                          mov     eax,-2cH[ebp]
 09a8  ff 30                             push    [eax]
 09aa  e8 00 00 00 00                    call    computePlane_
 09af  8d 45 88                          lea     eax,-78H[ebp]
 09b2  50                                push    eax
 09b3  8b 45 d4                          mov     eax,-2cH[ebp]
 09b6  50                                push    eax
 09b7  8d 4d e4                          lea     ecx,-1cH[ebp]
 09ba  8d 9d 50 ff ff ff                 lea     ebx,-0b0H[ebp]
 09c0  8d 95 50 ff ff ff                 lea     edx,-0b0H[ebp]
 09c6  8d 85 50 ff ff ff                 lea     eax,-0b0H[ebp]
 09cc  e8 00 00 00 00                    call    allocFace_
 09d1  89 c3                             mov     ebx,eax
 09d3  8d 55 c4                          lea     edx,-3cH[ebp]
 09d6  8b 45 d0                          mov     eax,-30H[ebp]
 09d9  e8 00 00 00 00                    call    appendFace_
 09de  83 7d dc 00       L30             cmp     dword ptr -24H[ebp],00000000H
 09e2  0f 84 35 01 00 00                 je      L33
 09e8  83 3d 00 00 00 00 
       04                                cmp     dword ptr _NumberOfObjects,00000004H
 09ef  7c 1a                             jl      L31
 09f1  6a 04                             push    00000004H
 09f3  b8 78 01 00 00                    mov     eax,offset L98
 09f8  50                                push    eax
 09f9  e8 00 00 00 00                    call    printf_
 09fe  83 c4 08                          add     esp,00000008H
 0a01  b8 ff ff ff ff                    mov     eax,0ffffffffH
 0a06  e8 00 00 00 00                    call    exit_
 0a0b  8b 45 dc          L31             mov     eax,-24H[ebp]
 0a0e  ff 70 10                          push    +10H[eax]
 0a11  8b 45 dc                          mov     eax,-24H[ebp]
 0a14  ff 70 0c                          push    +0cH[eax]
 0a17  8b 45 dc                          mov     eax,-24H[ebp]
 0a1a  ff 70 08                          push    +8H[eax]
 0a1d  8b 45 dc                          mov     eax,-24H[ebp]
 0a20  ff 70 04                          push    +4H[eax]
 0a23  8b 45 dc                          mov     eax,-24H[ebp]
 0a26  ff 30                             push    [eax]
 0a28  e8 00 00 00 00                    call    allocVertex_
 0a2d  89 c3                             mov     ebx,eax
 0a2f  8d 55 e0                          lea     edx,-20H[ebp]
 0a32  8d 45 dc                          lea     eax,-24H[ebp]
 0a35  e8 00 00 00 00                    call    appendVertex_
 0a3a  8d 85 78 ff ff ff                 lea     eax,-88H[ebp]
 0a40  50                                push    eax
 0a41  8b 45 dc                          mov     eax,-24H[ebp]
 0a44  8b 40 14                          mov     eax,+14H[eax]
 0a47  8b 40 14                          mov     eax,+14H[eax]
 0a4a  ff 70 08                          push    +8H[eax]
 0a4d  8b 45 dc                          mov     eax,-24H[ebp]
 0a50  8b 40 14                          mov     eax,+14H[eax]
 0a53  8b 40 14                          mov     eax,+14H[eax]
 0a56  ff 70 04                          push    +4H[eax]
 0a59  8b 45 dc                          mov     eax,-24H[ebp]
 0a5c  8b 40 14                          mov     eax,+14H[eax]
 0a5f  8b 40 14                          mov     eax,+14H[eax]
 0a62  ff 30                             push    [eax]
 0a64  8b 45 dc                          mov     eax,-24H[ebp]
 0a67  8b 40 14                          mov     eax,+14H[eax]
 0a6a  ff 70 08                          push    +8H[eax]
 0a6d  8b 45 dc                          mov     eax,-24H[ebp]
 0a70  8b 40 14                          mov     eax,+14H[eax]
 0a73  ff 70 04                          push    +4H[eax]
 0a76  8b 45 dc                          mov     eax,-24H[ebp]
 0a79  8b 40 14                          mov     eax,+14H[eax]
 0a7c  ff 30                             push    [eax]
 0a7e  8b 45 dc                          mov     eax,-24H[ebp]
 0a81  ff 70 08                          push    +8H[eax]
 0a84  8b 45 dc                          mov     eax,-24H[ebp]
 0a87  ff 70 04                          push    +4H[eax]
 0a8a  8b 45 dc                          mov     eax,-24H[ebp]
 0a8d  ff 30                             push    [eax]
 0a8f  e8 00 00 00 00                    call    computePlane_
 0a94  8d 85 78 ff ff ff                 lea     eax,-88H[ebp]
 0a9a  50                                push    eax
 0a9b  8b 45 dc                          mov     eax,-24H[ebp]
 0a9e  50                                push    eax
 0a9f  8d 4d ec                          lea     ecx,-14H[ebp]
 0aa2  8d 9d 28 ff ff ff                 lea     ebx,-0d8H[ebp]
 0aa8  8d 95 28 ff ff ff                 lea     edx,-0d8H[ebp]
 0aae  8d 85 28 ff ff ff                 lea     eax,-0d8H[ebp]
 0ab4  e8 00 00 00 00                    call    allocmovingFace_
 0ab9  89 c3                             mov     ebx,eax
 0abb  8d 55 c8                          lea     edx,-38H[ebp]
 0abe  8d 45 c0                          lea     eax,-40H[ebp]
 0ac1  e8 00 00 00 00                    call    appendFace_
 0ac6  83 7d f4 00                       cmp     dword ptr -0cH[ebp],00000000H
 0aca  75 20                             jne     L32
 0acc  ff 35 00 00 00 00                 push    _linenumber
 0ad2  b8 aa 01 00 00                    mov     eax,offset L99
 0ad7  50                                push    eax
 0ad8  e8 00 00 00 00                    call    printf_
 0add  83 c4 08                          add     esp,00000008H
 0ae0  b8 ff ff ff ff                    mov     eax,0ffffffffH
 0ae5  e8 00 00 00 00                    call    exit_
 0aea  eb 31                             jmp     L33
 0aec  8b 45 f8          L32             mov     eax,-8H[ebp]
 0aef  50                                push    eax
 0af0  8b 45 c0                          mov     eax,-40H[ebp]
 0af3  50                                push    eax
 0af4  8d bd e0 fe ff ff                 lea     edi,-120H[ebp]
 0afa  8d 75 98                          lea     esi,-68H[ebp]
 0afd  a5                                movsd   
 0afe  a5                                movsd   
 0aff  a5                                movsd   
 0b00  ff b5 e8 fe ff ff                 push    -118H[ebp]
 0b06  ff b5 e4 fe ff ff                 push    -11cH[ebp]
 0b0c  ff b5 e0 fe ff ff                 push    -120H[ebp]
 0b12  e8 00 00 00 00                    call    AddObject_
 0b17  ff 05 00 00 00 00                 inc     dword ptr _NumberOfObjects
 0b1d  8b 45 fc          L33             mov     eax,-4H[ebp]
 0b20  e8 00 00 00 00                    call    fclose_
 0b25  89 ec                             mov     esp,ebp
 0b27  5d                                pop     ebp
 0b28  5f                                pop     edi
 0b29  5e                                pop     esi
 0b2a  59                                pop     ecx
 0b2b  c3                                ret     
 0b2c  53                setmode_        push    ebx
 0b2d  51                                push    ecx
 0b2e  52                                push    edx
 0b2f  56                                push    esi
 0b30  57                                push    edi
 0b31  55                                push    ebp
 0b32  89 e5                             mov     ebp,esp
 0b34  81 ec 3c 00 00 00                 sub     esp,0000003cH
 0b3a  89 45 fc                          mov     -4H[ebp],eax
 0b3d  31 c0                             xor     eax,eax
 0b3f  66 8b 45 fc                       mov     ax,-4H[ebp]
 0b43  89 45 c4                          mov     -3cH[ebp],eax
 0b46  8d 5d e0                          lea     ebx,-20H[ebp]
 0b49  8d 55 c4                          lea     edx,-3cH[ebp]
 0b4c  b8 10 00 00 00                    mov     eax,00000010H
 0b51  e8 00 00 00 00                    call    int386_
 0b56  89 ec                             mov     esp,ebp
 0b58  5d                                pop     ebp
 0b59  5f                                pop     edi
 0b5a  5e                                pop     esi
 0b5b  5a                                pop     edx
 0b5c  59                                pop     ecx
 0b5d  5b                                pop     ebx
 0b5e  c3                                ret     
 0b5f  53                CheckKeys_      push    ebx
 0b60  51                                push    ecx
 0b61  52                                push    edx
 0b62  56                                push    esi
 0b63  57                                push    edi
 0b64  55                                push    ebp
 0b65  89 e5                             mov     ebp,esp
 0b67  81 ec 08 00 00 00                 sub     esp,00000008H
 0b6d  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _gravitationvec,00000000H
 0b77  c7 05 04 00 00 00 
       00 00 80 bf                       mov     dword ptr _gravitationvec+4H,0bf800000H
 0b81  c7 05 08 00 00 00 
       00 00 00 00                       mov     dword ptr _gravitationvec+8H,00000000H
 0b8b  83 3d 00 00 00 00 
       00                                cmp     dword ptr _shooting,00000000H
 0b92  7e 09                             jle     L34
 0b94  83 3d 48 00 00 00 
       00                                cmp     dword ptr _keyBoard+48H,00000000H
 0b9b  74 02                             je      L35
 0b9d  eb 26             L34             jmp     L36
 0b9f  68 00 00 70 41    L35             push    41700000H
 0ba4  ff 35 08 00 00 00                 push    _currentpos+8H
 0baa  ff 35 04 00 00 00                 push    _currentpos+4H
 0bb0  ff 35 00 00 00 00                 push    _currentpos
 0bb6  e8 00 00 00 00                    call    MakeNewObject_
 0bbb  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _shooting,00000000H
 0bc5  83 3d 00 00 00 00 
       01                L36             cmp     dword ptr _largerwindow,00000001H
 0bcc  75 09                             jne     L37
 0bce  83 3d 28 00 00 00 
       00                                cmp     dword ptr _keyBoard+28H,00000000H
 0bd5  74 02                             je      L38
 0bd7  eb 0a             L37             jmp     L39
 0bd9  c7 05 00 00 00 00 
       00 00 00 00       L38             mov     dword ptr _largerwindow,00000000H
 0be3  83 3d 00 00 00 00 
       01                L39             cmp     dword ptr _smallerwindow,00000001H
 0bea  75 09                             jne     L40
 0bec  83 3d 2c 00 00 00 
       00                                cmp     dword ptr _keyBoard+2cH,00000000H
 0bf3  74 02                             je      L41
 0bf5  eb 0a             L40             jmp     L42
 0bf7  c7 05 00 00 00 00 
       00 00 00 00       L41             mov     dword ptr _smallerwindow,00000000H
 0c01  c7 05 00 00 00 00 
       00 00 00 00       L42             mov     dword ptr _playeraccel,00000000H
 0c0b  83 3d 0c 00 00 00 
       00                                cmp     dword ptr _keyBoard+0cH,00000000H
 0c12  74 0a                             je      L43
 0c14  c7 05 00 00 00 00 
       00 00 80 bf                       mov     dword ptr _playeraccel,0bf800000H
 0c1e  83 3d 08 00 00 00 
       00                L43             cmp     dword ptr _keyBoard+8H,00000000H
 0c25  74 0a                             je      L44
 0c27  c7 05 00 00 00 00 
       00 00 80 3f                       mov     dword ptr _playeraccel,3f800000H
 0c31  83 3d 14 00 00 00 
       00                L44             cmp     dword ptr _keyBoard+14H,00000000H
 0c38  74 4f                             je      L45
 0c3a  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0c40  dc 0d eb 01 00 00                 fmul    qword ptr L100
 0c46  d9 05 00 00 00 00                 fld     dword ptr _playerpitch
 0c4c  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0c4f  dc 6d f8                          fsubr   qword ptr -8H[ebp]
 0c52  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0c55  dd 45 f8                          fld     qword ptr -8H[ebp]
 0c58  d9 1d 00 00 00 00                 fstp    dword ptr _playerpitch
 0c5e  d9 ee                             fldz    
 0c60  d8 1d 00 00 00 00                 fcomp   dword ptr _playerpitch
 0c66  df e0                             fstsw   ax
 0c68  9e                                sahf    
 0c69  76 1e                             jbe     L45
 0c6b  d9 05 00 00 00 00                 fld     dword ptr _playerpitch
 0c71  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0c74  dd 45 f8                          fld     qword ptr -8H[ebp]
 0c77  dc 05 f3 01 00 00                 fadd    qword ptr L101
 0c7d  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0c80  dd 45 f8                          fld     qword ptr -8H[ebp]
 0c83  d9 1d 00 00 00 00                 fstp    dword ptr _playerpitch
 0c89  83 3d 18 00 00 00 
       00                L45             cmp     dword ptr _keyBoard+18H,00000000H
 0c90  74 47                             je      L46
 0c92  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0c98  dc 0d fb 01 00 00                 fmul    qword ptr L102
 0c9e  d9 05 00 00 00 00                 fld     dword ptr _playerpitch
 0ca4  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0ca7  dc 45 f8                          fadd    qword ptr -8H[ebp]
 0caa  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0cad  dd 45 f8                          fld     qword ptr -8H[ebp]
 0cb0  d9 1d 00 00 00 00                 fstp    dword ptr _playerpitch
 0cb6  d9 05 00 00 00 00                 fld     dword ptr _playerpitch
 0cbc  dc 1d 03 02 00 00                 fcomp   qword ptr L103
 0cc2  df e0                             fstsw   ax
 0cc4  9e                                sahf    
 0cc5  72 12                             jb      L46
 0cc7  d9 05 00 00 00 00                 fld     dword ptr _playerpitch
 0ccd  dc 05 0b 02 00 00                 fadd    qword ptr L104
 0cd3  d9 1d 00 00 00 00                 fstp    dword ptr _playerpitch
 0cd9  83 3d 40 00 00 00 
       00                L46             cmp     dword ptr _keyBoard+40H,00000000H
 0ce0  74 1e                             je      L47
 0ce2  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _gravitationvec,00000000H
 0cec  c7 05 04 00 00 00 
       00 00 80 3f                       mov     dword ptr _gravitationvec+4H,3f800000H
 0cf6  c7 05 08 00 00 00 
       00 00 00 00                       mov     dword ptr _gravitationvec+8H,00000000H
 0d00  83 3d 48 00 00 00 
       00                L47             cmp     dword ptr _keyBoard+48H,00000000H
 0d07  74 1a                             je      L50
 0d09  83 3d 00 00 00 00 
       00                                cmp     dword ptr _shooting,00000000H
 0d10  7c 09                             jl      L48
 0d12  83 3d 00 00 00 00 
       7b                                cmp     dword ptr _shooting,0000007bH
 0d19  7c 02                             jl      L49
 0d1b  eb 06             L48             jmp     L50
 0d1d  ff 05 00 00 00 00 L49             inc     dword ptr _shooting
 0d23  83 3d 04 00 00 00 
       00                L50             cmp     dword ptr _keyBoard+4H,00000000H
 0d2a  74 53                             je      L51
 0d2c  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0d32  dc 0d 13 02 00 00                 fmul    qword ptr L105
 0d38  d9 05 00 00 00 00                 fld     dword ptr _playeryawspeed
 0d3e  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0d41  dc 6d f8                          fsubr   qword ptr -8H[ebp]
 0d44  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0d47  dd 45 f8                          fld     qword ptr -8H[ebp]
 0d4a  d9 1d 00 00 00 00                 fstp    dword ptr _playeryawspeed
 0d50  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0d56  dc 0d 1b 02 00 00                 fmul    qword ptr L106
 0d5c  d9 e0                             fchs    
 0d5e  d9 05 00 00 00 00                 fld     dword ptr _playeryawspeed
 0d64  de d9                             fcompp  st(1)
 0d66  df e0                             fstsw   ax
 0d68  9e                                sahf    
 0d69  73 14                             jae     L51
 0d6b  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0d71  dc 0d 23 02 00 00                 fmul    qword ptr L107
 0d77  d9 e0                             fchs    
 0d79  d9 1d 00 00 00 00                 fstp    dword ptr _playeryawspeed
 0d7f  83 3d 00 00 00 00 
       00                L51             cmp     dword ptr _keyBoard,00000000H
 0d86  74 4f                             je      L52
 0d88  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0d8e  dc 0d 2b 02 00 00                 fmul    qword ptr L108
 0d94  d9 05 00 00 00 00                 fld     dword ptr _playeryawspeed
 0d9a  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0d9d  dc 45 f8                          fadd    qword ptr -8H[ebp]
 0da0  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0da3  dd 45 f8                          fld     qword ptr -8H[ebp]
 0da6  d9 1d 00 00 00 00                 fstp    dword ptr _playeryawspeed
 0dac  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0db2  dc 0d 33 02 00 00                 fmul    qword ptr L109
 0db8  d9 05 00 00 00 00                 fld     dword ptr _playeryawspeed
 0dbe  de d9                             fcompp  st(1)
 0dc0  df e0                             fstsw   ax
 0dc2  9e                                sahf    
 0dc3  76 12                             jbe     L52
 0dc5  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0dcb  dc 0d 3b 02 00 00                 fmul    qword ptr L110
 0dd1  d9 1d 00 00 00 00                 fstp    dword ptr _playeryawspeed
 0dd7  83 3d 2c 00 00 00 
       00                L52             cmp     dword ptr _keyBoard+2cH,00000000H
 0dde  74 3d                             je      L54
 0de0  83 3d 00 00 00 00 
       00                                cmp     dword ptr _smallerwindow,00000000H
 0de7  75 34                             jne     L54
 0de9  83 3d 00 00 00 00 
       32                                cmp     dword ptr _DIBWidth,00000032H
 0df0  7e 1c                             jle     L53
 0df2  83 2d 00 00 00 00 
       20                                sub     dword ptr _DIBWidth,00000020H
 0df9  83 2d 00 00 00 00 
       14                                sub     dword ptr _DIBHeight,00000014H
 0e00  83 05 00 00 00 00 
       10                                add     dword ptr _WindowOffsetX,00000010H
 0e07  83 05 00 00 00 00 
       0a                                add     dword ptr _WindowOffsetY,0000000aH
 0e0e  e8 00 00 00 00    L53             call    UpdateDraw_
 0e13  c7 05 00 00 00 00 
       01 00 00 00                       mov     dword ptr _smallerwindow,00000001H
 0e1d  83 3d 28 00 00 00 
       00                L54             cmp     dword ptr _keyBoard+28H,00000000H
 0e24  74 69                             je      L56
 0e26  83 3d 00 00 00 00 
       00                                cmp     dword ptr _largerwindow,00000000H
 0e2d  75 60                             jne     L56
 0e2f  83 05 00 00 00 00 
       20                                add     dword ptr _DIBWidth,00000020H
 0e36  83 05 00 00 00 00 
       14                                add     dword ptr _DIBHeight,00000014H
 0e3d  83 2d 00 00 00 00 
       10                                sub     dword ptr _WindowOffsetX,00000010H
 0e44  83 2d 00 00 00 00 
       0a                                sub     dword ptr _WindowOffsetY,0000000aH
 0e4b  a1 00 00 00 00                    mov     eax,_DIBWidth
 0e50  3b 05 00 00 00 00                 cmp     eax,_INITIAL_WINDOW_WIDTH
 0e56  7e 28                             jle     L55
 0e58  a1 00 00 00 00                    mov     eax,_INITIAL_WINDOW_WIDTH
 0e5d  a3 00 00 00 00                    mov     _DIBWidth,eax
 0e62  a1 00 00 00 00                    mov     eax,_INITIAL_WINDOW_HEIGHT
 0e67  a3 00 00 00 00                    mov     _DIBHeight,eax
 0e6c  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _WindowOffsetY,00000000H
 0e76  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _WindowOffsetX,00000000H
 0e80  e8 00 00 00 00    L55             call    UpdateDraw_
 0e85  c7 05 00 00 00 00 
       01 00 00 00                       mov     dword ptr _largerwindow,00000001H
 0e8f  83 3d 10 00 00 00 
       00                L56             cmp     dword ptr _keyBoard+10H,00000000H
 0e96  74 4f                             je      L57
 0e98  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0e9e  dc 0d 43 02 00 00                 fmul    qword ptr L111
 0ea4  d9 05 00 00 00 00                 fld     dword ptr _playerroll
 0eaa  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0ead  dc 6d f8                          fsubr   qword ptr -8H[ebp]
 0eb0  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0eb3  dd 45 f8                          fld     qword ptr -8H[ebp]
 0eb6  d9 1d 00 00 00 00                 fstp    dword ptr _playerroll
 0ebc  d9 ee                             fldz    
 0ebe  d8 1d 00 00 00 00                 fcomp   dword ptr _playerroll
 0ec4  df e0                             fstsw   ax
 0ec6  9e                                sahf    
 0ec7  76 1e                             jbe     L57
 0ec9  d9 05 00 00 00 00                 fld     dword ptr _playerroll
 0ecf  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0ed2  dd 45 f8                          fld     qword ptr -8H[ebp]
 0ed5  dc 05 4b 02 00 00                 fadd    qword ptr L112
 0edb  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0ede  dd 45 f8                          fld     qword ptr -8H[ebp]
 0ee1  d9 1d 00 00 00 00                 fstp    dword ptr _playerroll
 0ee7  83 3d 1c 00 00 00 
       00                L57             cmp     dword ptr _keyBoard+1cH,00000000H
 0eee  74 47                             je      L58
 0ef0  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0ef6  dc 0d 53 02 00 00                 fmul    qword ptr L113
 0efc  d9 05 00 00 00 00                 fld     dword ptr _playerroll
 0f02  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0f05  dc 45 f8                          fadd    qword ptr -8H[ebp]
 0f08  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0f0b  dd 45 f8                          fld     qword ptr -8H[ebp]
 0f0e  d9 1d 00 00 00 00                 fstp    dword ptr _playerroll
 0f14  d9 05 00 00 00 00                 fld     dword ptr _playerroll
 0f1a  dc 1d 5b 02 00 00                 fcomp   qword ptr L114
 0f20  df e0                             fstsw   ax
 0f22  9e                                sahf    
 0f23  72 12                             jb      L58
 0f25  d9 05 00 00 00 00                 fld     dword ptr _playerroll
 0f2b  dc 05 63 02 00 00                 fadd    qword ptr L115
 0f31  d9 1d 00 00 00 00                 fstp    dword ptr _playerroll
 0f37  83 3d 34 00 00 00 
       00                L58             cmp     dword ptr _keyBoard+34H,00000000H
 0f3e  74 27                             je      L59
 0f40  83 3d 00 00 00 00 
       00                                cmp     dword ptr _currentMode,00000000H
 0f47  7e 1e                             jle     L59
 0f49  ff 0d 00 00 00 00                 dec     dword ptr _currentMode
 0f4f  a1 00 00 00 00                    mov     eax,_currentMode
 0f54  c1 e0 02                          shl     eax,02H
 0f57  8b 80 00 00 00 00                 mov     eax,_modeMenu[eax]
 0f5d  e8 00 00 00 00                    call    coockieSetMode_
 0f62  e8 00 00 00 00                    call    InitDraw_
 0f67  83 3d 38 00 00 00 
       00                L59             cmp     dword ptr _keyBoard+38H,00000000H
 0f6e  74 2b                             je      L60
 0f70  a1 00 00 00 00                    mov     eax,_currentMode
 0f75  3b 05 00 00 00 00                 cmp     eax,_lastMode
 0f7b  7d 1e                             jge     L60
 0f7d  ff 05 00 00 00 00                 inc     dword ptr _currentMode
 0f83  a1 00 00 00 00                    mov     eax,_currentMode
 0f88  c1 e0 02                          shl     eax,02H
 0f8b  8b 80 00 00 00 00                 mov     eax,_modeMenu[eax]
 0f91  e8 00 00 00 00                    call    coockieSetMode_
 0f96  e8 00 00 00 00                    call    InitDraw_
 0f9b  83 3d 44 00 00 00 
       00                L60             cmp     dword ptr _keyBoard+44H,00000000H
 0fa2  74 1e                             je      L61
 0fa4  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0faa  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0fad  dd 45 f8                          fld     qword ptr -8H[ebp]
 0fb0  dc 0d 6b 02 00 00                 fmul    qword ptr L116
 0fb6  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0fb9  dd 45 f8                          fld     qword ptr -8H[ebp]
 0fbc  d9 1d 00 00 00 00                 fstp    dword ptr _playerspeedscale
 0fc2  83 3d 50 00 00 00 
       00                L61             cmp     dword ptr _keyBoard+50H,00000000H
 0fc9  74 05                             je      L62
 0fcb  e8 00 00 00 00                    call    InitDraw_
 0fd0  83 3d 4c 00 00 00 
       00                L62             cmp     dword ptr _keyBoard+4cH,00000000H
 0fd7  74 1e                             je      L63
 0fd9  d9 05 00 00 00 00                 fld     dword ptr _playerspeedscale
 0fdf  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0fe2  dd 45 f8                          fld     qword ptr -8H[ebp]
 0fe5  dc 0d 73 02 00 00                 fmul    qword ptr L117
 0feb  dd 5d f8                          fstp    qword ptr -8H[ebp]
 0fee  dd 45 f8                          fld     qword ptr -8H[ebp]
 0ff1  d9 1d 00 00 00 00                 fstp    dword ptr _playerspeedscale
 0ff7  89 ec             L63             mov     esp,ebp
 0ff9  5d                                pop     ebp
 0ffa  5f                                pop     edi
 0ffb  5e                                pop     esi
 0ffc  5a                                pop     edx
 0ffd  59                                pop     ecx
 0ffe  5b                                pop     ebx
 0fff  c3                                ret     
 1000  53                coockieSETMODE_ push    ebx
 1001  51                                push    ecx
 1002  52                                push    edx
 1003  56                                push    esi
 1004  57                                push    edi
 1005  55                                push    ebp
 1006  89 e5                             mov     ebp,esp
 1008  81 ec 04 01 00 00                 sub     esp,00000104H
 100e  89 45 fc                          mov     -4H[ebp],eax
 1011  83 7d fc ff                       cmp     dword ptr -4H[ebp],0ffffffffH
 1015  75 74                             jne     L64
 1017  c7 05 00 00 00 00 
       40 01 00 00                       mov     dword ptr _INITIAL_DIB_WIDTH,00000140H
 1021  c7 05 00 00 00 00 
       c8 00 00 00                       mov     dword ptr _INITIAL_DIB_HEIGHT,000000c8H
 102b  c7 05 00 00 00 00 
       40 01 00 00                       mov     dword ptr _INITIAL_WINDOW_WIDTH,00000140H
 1035  c7 05 00 00 00 00 
       c8 00 00 00                       mov     dword ptr _INITIAL_WINDOW_HEIGHT,000000c8H
 103f  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _screenbuffer,00000000H
 1049  8d 95 fc fe ff ff                 lea     edx,-104H[ebp]
 104f  b8 13 00 00 00                    mov     eax,00000013H
 1054  e8 00 00 00 00                    call    VBE_getModeInfo_
 1059  b9 40 00 00 00                    mov     ecx,00000040H
 105e  bf 00 00 00 00                    mov     edi,offset _coockieModeInfo
 1063  8d b5 fc fe ff ff                 lea     esi,-104H[ebp]
 1069  f3 a5                             repe    movsd    
 106b  c7 05 00 00 00 00 
       00 00 0a 00                       mov     dword ptr _VideoOffset,000a0000H
 1075  b8 13 00 00 00                    mov     eax,00000013H
 107a  e8 00 00 00 00                    call    setmode_
 107f  b8 00 00 00 00                    mov     eax,offset _globalpalette
 1084  e8 00 00 00 00                    call    SetVGAPalette_
 1089  eb 76                             jmp     L65
 108b  8d 95 fc fe ff ff L64             lea     edx,-104H[ebp]
 1091  8b 45 fc                          mov     eax,-4H[ebp]
 1094  e8 00 00 00 00                    call    VBE_getModeInfo_
 1099  8b 45 fc                          mov     eax,-4H[ebp]
 109c  e8 00 00 00 00                    call    SV_setMode_
 10a1  0f bf 85 0e ff ff 
       ff                                movsx   eax,word ptr -0f2H[ebp]
 10a8  a3 00 00 00 00                    mov     _INITIAL_DIB_WIDTH,eax
 10ad  0f bf 85 10 ff ff 
       ff                                movsx   eax,word ptr -0f0H[ebp]
 10b4  a3 00 00 00 00                    mov     _INITIAL_DIB_HEIGHT,eax
 10b9  0f bf 85 0e ff ff 
       ff                                movsx   eax,word ptr -0f2H[ebp]
 10c0  a3 00 00 00 00                    mov     _INITIAL_WINDOW_WIDTH,eax
 10c5  0f bf 85 10 ff ff 
       ff                                movsx   eax,word ptr -0f0H[ebp]
 10cc  a3 00 00 00 00                    mov     _INITIAL_WINDOW_HEIGHT,eax
 10d1  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _screenbuffer,00000000H
 10db  b9 40 00 00 00                    mov     ecx,00000040H
 10e0  bf 00 00 00 00                    mov     edi,offset _coockieModeInfo
 10e5  8d b5 fc fe ff ff                 lea     esi,-104H[ebp]
 10eb  f3 a5                             repe    movsd    
 10ed  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _VideoOffset,00000000H
 10f7  b8 00 00 00 00                    mov     eax,offset _globalpalette
 10fc  e8 00 00 00 00                    call    SetVGAPalette_
 1101  89 ec             L65             mov     esp,ebp
 1103  5d                                pop     ebp
 1104  5f                                pop     edi
 1105  5e                                pop     esi
 1106  5a                                pop     edx
 1107  59                                pop     ecx
 1108  5b                                pop     ebx
 1109  c3                                ret     
 110a                    coockieVBE_INIT_:
 110a  53                                push    ebx
 110b  51                                push    ecx
 110c  52                                push    edx
 110d  56                                push    esi
 110e  57                                push    edi
 110f  55                                push    ebp
 1110  89 e5                             mov     ebp,esp
 1112  81 ec 0c 01 00 00                 sub     esp,0000010cH
 1118  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _currentMode,00000000H
 1122  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _lastMode,00000000H
 112c  a1 00 00 00 00                    mov     eax,_currentMode
 1131  c1 e0 02                          shl     eax,02H
 1134  c7 80 00 00 00 00 
       ff ff ff ff                       mov     dword ptr _modeMenu[eax],0ffffffffH
 113e  e8 00 00 00 00                    call    SV_init_
 1143  a3 00 00 00 00                    mov     _VBEVersion,eax
 1148  81 3d 00 00 00 00 
       00 02 00 00                       cmp     dword ptr _VBEVersion,00000200H
 1152  7d 34                             jge     L66
 1154  b8 7b 02 00 00                    mov     eax,offset L118
 1159  50                                push    eax
 115a  e8 00 00 00 00                    call    printf_
 115f  83 c4 04                          add     esp,00000004H
 1162  b8 c4 02 00 00                    mov     eax,offset L119
 1167  50                                push    eax
 1168  e8 00 00 00 00                    call    printf_
 116d  83 c4 04                          add     esp,00000004H
 1170  b8 0c 03 00 00                    mov     eax,offset L120
 1175  50                                push    eax
 1176  e8 00 00 00 00                    call    printf_
 117b  83 c4 04                          add     esp,00000004H
 117e  b8 01 00 00 00                    mov     eax,00000001H
 1183  e8 00 00 00 00                    call    exit_
 1188  e8 00 00 00 00    L66             call    getValidGraphicsMode_
 118d  e8 00 00 00 00                    call    SV_setMode_
 1192  e8 00 00 00 00                    call    SV_restoreMode_
 1197  83 3d 00 00 00 00 
       00                                cmp     dword ptr _linearAddr,00000000H
 119e  0f 84 15 01 00 00                 je      L75
 11a4  c7 45 f8 00 00 00 
       00                                mov     dword ptr -8H[ebp],offset _modeList
 11ab  8b 45 f8          L67             mov     eax,-8H[ebp]
 11ae  66 83 38 ff                       cmp     word ptr [eax],0ffffH
 11b2  75 0e                             jne     L69
 11b4  e9 fe 00 00 00                    jmp     L74
 11b9  8b 45 f8          L68             mov     eax,-8H[ebp]
 11bc  83 45 f8 02                       add     dword ptr -8H[ebp],00000002H
 11c0  eb e9                             jmp     L67
 11c2  8b 45 f8          L69             mov     eax,-8H[ebp]
 11c5  66 8b 00                          mov     ax,[eax]
 11c8  80 cc 40                          or      ah,40H
 11cb  89 45 fc                          mov     -4H[ebp],eax
 11ce  8d 95 f4 fe ff ff                 lea     edx,-10cH[ebp]
 11d4  31 c0                             xor     eax,eax
 11d6  66 8b 45 fc                       mov     ax,-4H[ebp]
 11da  e8 00 00 00 00                    call    VBE_getModeInfo_
 11df  66 85 c0                          test    ax,ax
 11e2  74 d5                             je      L68
 11e4  80 bd 0d ff ff ff 
       08                                cmp     byte ptr -0f3H[ebp],08H
 11eb  75 0a                             jne     L70
 11ed  66 83 bd 06 ff ff 
       ff 00                             cmp     word ptr -0faH[ebp],0000H
 11f5  75 02                             jne     L71
 11f7  eb c0             L70             jmp     L68
 11f9  66 f7 85 f4 fe ff 
       ff 80 00          L71             test    word ptr -10cH[ebp],0080H
 1202  74 b5                             je      L68
 1204  31 c0                             xor     eax,eax
 1206  66 8b 45 fc                       mov     ax,-4H[ebp]
 120a  e8 00 00 00 00                    call    SV_setMode_
 120f  66 85 c0                          test    ax,ax
 1212  75 2f                             jne     L72
 1214  b8 3a 03 00 00                    mov     eax,offset L121
 1219  50                                push    eax
 121a  e8 00 00 00 00                    call    printf_
 121f  83 c4 04                          add     esp,00000004H
 1222  b8 3c 03 00 00                    mov     eax,offset L122
 1227  50                                push    eax
 1228  e8 00 00 00 00                    call    printf_
 122d  83 c4 04                          add     esp,00000004H
 1230  b8 67 03 00 00                    mov     eax,offset L123
 1235  50                                push    eax
 1236  e8 00 00 00 00                    call    printf_
 123b  83 c4 04                          add     esp,00000004H
 123e  e9 76 ff ff ff                    jmp     L68
 1243  0f bf 85 06 ff ff 
       ff                L72             movsx   eax,word ptr -0faH[ebp]
 124a  a3 00 00 00 00                    mov     _INITIAL_DIB_WIDTH,eax
 124f  0f bf 85 08 ff ff 
       ff                                movsx   eax,word ptr -0f8H[ebp]
 1256  a3 00 00 00 00                    mov     _INITIAL_DIB_HEIGHT,eax
 125b  0f bf 85 06 ff ff 
       ff                                movsx   eax,word ptr -0faH[ebp]
 1262  a3 00 00 00 00                    mov     _INITIAL_WINDOW_WIDTH,eax
 1267  0f bf 85 08 ff ff 
       ff                                movsx   eax,word ptr -0f8H[ebp]
 126e  a3 00 00 00 00                    mov     _INITIAL_WINDOW_HEIGHT,eax
 1273  a1 00 00 00 00                    mov     eax,_linearAddr
 1278  a3 00 00 00 00                    mov     _screenbuffer,eax
 127d  b9 40 00 00 00                    mov     ecx,00000040H
 1282  bf 00 00 00 00                    mov     edi,offset _coockieModeInfo
 1287  8d b5 f4 fe ff ff                 lea     esi,-10cH[ebp]
 128d  f3 a5                             repe    movsd    
 128f  83 3d 00 00 00 00 
       64                                cmp     dword ptr _lastMode,00000064H
 1296  7d 1a                             jge     L73
 1298  ff 05 00 00 00 00                 inc     dword ptr _lastMode
 129e  31 d2                             xor     edx,edx
 12a0  66 8b 55 fc                       mov     dx,-4H[ebp]
 12a4  a1 00 00 00 00                    mov     eax,_lastMode
 12a9  c1 e0 02                          shl     eax,02H
 12ac  89 90 00 00 00 00                 mov     _modeMenu[eax],edx
 12b2  e9 02 ff ff ff    L73             jmp     L68
 12b7  eb 0e             L74             jmp     L76
 12b9  b8 86 03 00 00    L75             mov     eax,offset L124
 12be  50                                push    eax
 12bf  e8 00 00 00 00                    call    printf_
 12c4  83 c4 04                          add     esp,00000004H
 12c7  89 ec             L76             mov     esp,ebp
 12c9  5d                                pop     ebp
 12ca  5f                                pop     edi
 12cb  5e                                pop     esi
 12cc  5a                                pop     edx
 12cd  59                                pop     ecx
 12ce  5b                                pop     ebx
 12cf  c3                                ret     
 12d0  53                main_           push    ebx
 12d1  51                                push    ecx
 12d2  56                                push    esi
 12d3  57                                push    edi
 12d4  55                                push    ebp
 12d5  89 e5                             mov     ebp,esp
 12d7  81 ec 44 00 00 00                 sub     esp,00000044H
 12dd  89 45 f0                          mov     -10H[ebp],eax
 12e0  89 55 f4                          mov     -0cH[ebp],edx
 12e3  c7 45 c8 00 00 00 
       00                                mov     dword ptr -38H[ebp],00000000H
 12ea  c7 45 cc 00 00 00 
       00                                mov     dword ptr -34H[ebp],00000000H
 12f1  c7 45 d0 00 00 00 
       00                                mov     dword ptr -30H[ebp],00000000H
 12f8  c7 05 00 00 00 00 
       01 00 00 00                       mov     dword ptr _semaphore1,00000001H
 1302  c7 05 00 00 00 00 
       02 00 00 00                       mov     dword ptr _semaphore2,00000002H
 130c  83 7d f0 02                       cmp     dword ptr -10H[ebp],00000002H
 1310  7d 23                             jge     L77
 1312  8b 45 f4                          mov     eax,-0cH[ebp]
 1315  ff 30                             push    [eax]
 1317  b8 9e 03 00 00                    mov     eax,offset L125
 131c  50                                push    eax
 131d  b8 34 00 00 00                    mov     eax,offset ___iob+34H
 1322  50                                push    eax
 1323  e8 00 00 00 00                    call    fprintf_
 1328  83 c4 0c                          add     esp,0000000cH
 132b  b8 01 00 00 00                    mov     eax,00000001H
 1330  e8 00 00 00 00                    call    exit_
 1335  8d 5d ec          L77             lea     ebx,-14H[ebp]
 1338  8d 55 d4                          lea     edx,-2cH[ebp]
 133b  8b 45 f4                          mov     eax,-0cH[ebp]
 133e  8b 40 04                          mov     eax,+4H[eax]
 1341  e8 00 00 00 00                    call    getScene_
 1346  b8 b4 03 00 00                    mov     eax,offset L126
 134b  50                                push    eax
 134c  e8 00 00 00 00                    call    printf_
 1351  83 c4 04                          add     esp,00000004H
 1354  8b 45 ec                          mov     eax,-14H[ebp]
 1357  50                                push    eax
 1358  8d 7d bc                          lea     edi,-44H[ebp]
 135b  8d 75 c8                          lea     esi,-38H[ebp]
 135e  a5                                movsd   
 135f  a5                                movsd   
 1360  a5                                movsd   
 1361  ff 75 c4                          push    -3cH[ebp]
 1364  ff 75 c0                          push    -40H[ebp]
 1367  ff 75 bc                          push    -44H[ebp]
 136a  e8 00 00 00 00                    call    ComputeMagic_
 136f  b8 c8 03 00 00                    mov     eax,offset L127
 1374  50                                push    eax
 1375  e8 00 00 00 00                    call    printf_
 137a  83 c4 04                          add     esp,00000004H
 137d  8d 45 ec                          lea     eax,-14H[ebp]
 1380  e8 00 00 00 00                    call    BSPconstructTree_
 1385  a3 00 00 00 00                    mov     _root,eax
 138a  b8 e0 03 00 00                    mov     eax,offset L128
 138f  50                                push    eax
 1390  e8 00 00 00 00                    call    printf_
 1395  83 c4 04                          add     esp,00000004H
 1398  b8 fa 03 00 00                    mov     eax,offset L129
 139d  50                                push    eax
 139e  e8 00 00 00 00                    call    printf_
 13a3  83 c4 04                          add     esp,00000004H
 13a6  b8 2e 04 00 00                    mov     eax,offset L130
 13ab  50                                push    eax
 13ac  e8 00 00 00 00                    call    printf_
 13b1  83 c4 04                          add     esp,00000004H
 13b4  b8 58 04 00 00                    mov     eax,offset L131
 13b9  50                                push    eax
 13ba  e8 00 00 00 00                    call    printf_
 13bf  83 c4 04                          add     esp,00000004H
 13c2  b8 92 04 00 00                    mov     eax,offset L132
 13c7  50                                push    eax
 13c8  e8 00 00 00 00                    call    printf_
 13cd  83 c4 04                          add     esp,00000004H
 13d0  b8 ca 04 00 00                    mov     eax,offset L133
 13d5  50                                push    eax
 13d6  e8 00 00 00 00                    call    printf_
 13db  83 c4 04                          add     esp,00000004H
 13de  b8 07 05 00 00                    mov     eax,offset L134
 13e3  50                                push    eax
 13e4  e8 00 00 00 00                    call    printf_
 13e9  83 c4 04                          add     esp,00000004H
 13ec  b8 1f 05 00 00                    mov     eax,offset L135
 13f1  50                                push    eax
 13f2  e8 00 00 00 00                    call    printf_
 13f7  83 c4 04                          add     esp,00000004H
 13fa  e8 00 00 00 00                    call    getch_
 13ff  d9 05 00 00 00 00                 fld     dword ptr _currentpos
 1405  d9 1d 00 00 00 00                 fstp    dword ptr _playerposition
 140b  d9 05 08 00 00 00                 fld     dword ptr _currentpos+8H
 1411  d9 1d 04 00 00 00                 fstp    dword ptr _playerposition+4H
 1417  d9 05 04 00 00 00                 fld     dword ptr _currentpos+4H
 141d  d9 1d 08 00 00 00                 fstp    dword ptr _playerposition+8H
 1423  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _currentbspdepth,00000000H
 142d  e8 00 00 00 00                    call    Initialize_
 1432  e8 00 00 00 00                    call    coockieVBE_INIT_
 1437  c7 05 00 00 00 00 
       01 00 00 00                       mov     dword ptr _currentMode,00000001H
 1441  a1 00 00 00 00                    mov     eax,_currentMode
 1446  c1 e0 02                          shl     eax,02H
 1449  8b 80 00 00 00 00                 mov     eax,_modeMenu[eax]
 144f  e8 00 00 00 00                    call    coockieSetMode_
 1454  e8 00 00 00 00                    call    InitDraw_
 1459  ba 00 00 00 00                    mov     edx,offset _playerposition
 145e  a1 00 00 00 00                    mov     eax,_root
 1463  e8 00 00 00 00                    call    BSPtraverseTreeAndCalculateBoundingPlanes_
 1468  83 3d 30 00 00 00 
       00                L78             cmp     dword ptr _keyBoard+30H,00000000H
 146f  0f 85 95 00 00 00                 jne     L79
 1475  e8 00 00 00 00                    call    CheckKeys_
 147a  e8 00 00 00 00                    call    UpdateViewPos_
 147f  e8 00 00 00 00                    call    SetUpFrustum_
 1484  e8 00 00 00 00                    call    ClearEdgeLists_
 1489  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _pavailsurf,offset _surfs
 1493  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _pavailedge,offset _edges
 149d  8d 7d e0                          lea     edi,-20H[ebp]
 14a0  be 00 00 00 00                    mov     esi,offset _currentpos
 14a5  a5                                movsd   
 14a6  a5                                movsd   
 14a7  a5                                movsd   
 14a8  d9 05 00 00 00 00                 fld     dword ptr _currentpos
 14ae  d9 1d 00 00 00 00                 fstp    dword ptr _playerposition
 14b4  d9 05 08 00 00 00                 fld     dword ptr _currentpos+8H
 14ba  d9 1d 04 00 00 00                 fstp    dword ptr _playerposition+4H
 14c0  d9 05 04 00 00 00                 fld     dword ptr _currentpos+4H
 14c6  d9 1d 08 00 00 00                 fstp    dword ptr _playerposition+8H
 14cc  c7 05 00 00 00 00 
       00 00 00 00                       mov     dword ptr _currentbspdepth,00000000H
 14d6  a1 00 00 00 00                    mov     eax,_root
 14db  e8 00 00 00 00                    call    BSPtraverseTreeAndRender_
 14e0  e8 00 00 00 00                    call    UpdateObjectList_
 14e5  e8 00 00 00 00                    call    DrawObjectList_
 14ea  e8 00 00 00 00                    call    ScanEdges_
 14ef  e8 00 00 00 00                    call    DrawSpans_
 14f4  bf 00 00 00 00                    mov     edi,offset _currentpos
 14f9  8d 75 e0                          lea     esi,-20H[ebp]
 14fc  a5                                movsd   
 14fd  a5                                movsd   
 14fe  a5                                movsd   
 14ff  ff 05 00 00 00 00                 inc     dword ptr _frames
 1505  e9 5e ff ff ff                    jmp     L78
 150a  b8 00 00 00 00    L79             mov     eax,offset _root
 150f  e8 00 00 00 00                    call    BSPfreeTree_
 1514  e8 00 00 00 00                    call    CleanUp_
 1519  b8 03 00 00 00                    mov     eax,00000003H
 151e  e8 00 00 00 00                    call    setmode_
 1523  b8 43 05 00 00                    mov     eax,offset L136
 1528  50                                push    eax
 1529  e8 00 00 00 00                    call    printf_
 152e  83 c4 04                          add     esp,00000004H
 1531  b8 64 05 00 00                    mov     eax,offset L137
 1536  50                                push    eax
 1537  e8 00 00 00 00                    call    printf_
 153c  83 c4 04                          add     esp,00000004H
 153f  83 3d 00 00 00 00 
       00                                cmp     dword ptr _linearAddr,00000000H
 1546  74 16                             je      L80
 1548  ff 35 00 00 00 00                 push    _linearAddr
 154e  b8 9a 05 00 00                    mov     eax,offset L138
 1553  50                                push    eax
 1554  e8 00 00 00 00                    call    printf_
 1559  83 c4 08                          add     esp,00000008H
 155c  eb 0e                             jmp     L81
 155e  b8 ab 05 00 00    L80             mov     eax,offset L139
 1563  50                                push    eax
 1564  e8 00 00 00 00                    call    printf_
 1569  83 c4 04                          add     esp,00000004H
 156c  e8 00 00 00 00    L81             call    SV_restoreMode_
 1571  c7 45 fc 00 00 00 
       00                                mov     dword ptr -4H[ebp],00000000H
 1578  8b 45 fc                          mov     eax,-4H[ebp]
 157b  89 ec                             mov     esp,ebp
 157d  5d                                pop     ebp
 157e  5f                                pop     edi
 157f  5e                                pop     esi
 1580  59                                pop     ecx
 1581  5b                                pop     ebx
 1582  c3                                ret     

No disassembly errors

------------------------------------------------------------

Segment: CONST  DWORD USE32  000005b5 bytes  
 0000  25 73 0a 00             L82             - %s..
 0004  43 6f 75 6c 64 20 6e 6f L83             - Could no
 000c  74 20 66 69 6e 64 20 76                 - t find v
 0014  61 6c 69 64 20 76 69 64                 - alid vid
 001c  65 6f 20 6d 6f 64 65 21                 - eo mode!
 0024  21 21 0a 00                             - !!..
 0028  72 00                   L84             - r.
 002a  3f 55 6e 61 62 6c 65 20 L85             - ?Unable 
 0032  74 6f 20 6f 70 65 6e 20                 - to open 
 003a  25 73 20 0a 00                          - %s ..
 003f  46 69 6c 65 3a 20 25 73 L86             - File: %s
 0047  0a 00                                   - ..
 0049  25 2a 73 20 25 69 20 00 L87             - %*s %i .
 0051  25 2a 73 20 25 66 20 25 L88             - %*s %f %
 0059  66 20 25 66 20 25 66 20                 - f %f %f 
 0061  25 66 00                                - %f.
 0064  25 2a 73 20 25 73 00    L89             - %*s %s.
 006b  72 62 00                L90             - rb.
 006e  0a 46 69 6c 65 20 25 73 L91             - .File %s
 0076  20 6e 6f 74 20 66 6f 75                 -  not fou
 007e  6e 64 20 69 6e 20 6c 69                 - nd in li
 0086  6e 65 20 25 69 0a 0a 00                 - ne %i...
 008e  57 69 64 74 68 20 6f 72 L92             - Width or
 0096  20 48 65 69 67 68 74 20                 -  Height 
 009e  6f 66 20 70 63 78 20 25                 - of pcx %
 00a6  73 20 6e 6f 74 20 32 35                 - s not 25
 00ae  36 00                                   - 6.
 00b0  45 72 72 6f 72 3a 54 6f L93             - Error:To
 00b8  6f 20 6d 61 6e 79 20 74                 - o many t
 00c0  65 78 74 75 72 65 73 20                 - extures 
 00c8  64 65 66 69 6e 65 64 2c                 - defined,
 00d0  20 6f 6e 6c 79 20 25 69                 -  only %i
 00d8  20 61 6c 6c 6f 77 65 64                 -  allowed
 00e0  21 00                                   - !.
 00e2  45 72 72 6f 72 3a 20 74 L94             - Error: t
 00ea  6f 6f 20 6d 61 6e 79 20                 - oo many 
 00f2  6f 62 6a 65 63 74 73 20                 - objects 
 00fa  64 65 66 69 6e 65 64 2c                 - defined,
 0102  20 6f 6e 6c 79 20 25 69                 -  only %i
 010a  20 61 6c 6c 6f 77 65 64                 -  allowed
 0112  21 00                                   - !.
 0114  45 72 72 6f 72 3a 20 6f L95             - Error: o
 011c  62 6a 65 63 74 20 64 65                 - bject de
 0124  66 69 6e 69 74 69 6f 6e                 - finition
 012c  73 20 62 65 66 6f 72 65                 - s before
 0134  20 27 4f 62 6a 65 63 74                 -  'Object
 013c  27 20 64 65 63 6c 61 72                 - ' declar
 0144  61 74 69 6f 6e 20 69 6e                 - ation in
 014c  20 6c 69 6e 65 20 25 69                 -  line %i
 0154  00                                      - .
 0155  25 2a 73 20 25 69 20 25 L96             - %*s %i %
 015d  69 20 00                                - i .
 0160  3f 49 6c 6c 65 67 61 6c L97             - ?Illegal
 0168  20 63 6f 6d 6d 61 6e 64                 -  command
 0170  3a 20 27 25 63 27 0a 00                 - : '%c'..
 0178  45 72 72 6f 72 3a 20 74 L98             - Error: t
 0180  6f 6f 20 6d 61 6e 79 20                 - oo many 
 0188  6f 62 6a 65 63 74 73 20                 - objects 
 0190  64 65 66 69 6e 65 64 2c                 - defined,
 0198  20 6f 6e 6c 79 20 25 69                 -  only %i
 01a0  20 61 6c 6c 6f 77 65 64                 -  allowed
 01a8  21 00                                   - !.
 01aa  45 72 72 6f 72 3a 20 6f L99             - Error: o
 01b2  62 6a 65 63 74 20 64 65                 - bject de
 01ba  66 69 6e 69 74 69 6f 6e                 - finition
 01c2  73 20 62 65 66 6f 72 65                 - s before
 01ca  20 27 4f 62 6a 65 63 74                 -  'Object
 01d2  27 20 64 65 63 6c 61 72                 - ' declar
 01da  61 74 69 6f 6e 20 69 6e                 - ation in
 01e2  20 6c 69 6e 65 20 25 69                 -  line %i
 01ea  00                                      - .
 01eb  95 33 6f 30 2f 1b c4 3f L100            - .3o0/..?
 01f3  7a 00 8b fc fa 21 19 40 L101            - z....!.@
 01fb  95 33 6f 30 2f 1b c4 3f L102            - .3o0/..?
 0203  7a 00 8b fc fa 21 19 40 L103            - z....!.@
 020b  7a 00 8b fc fa 21 19 c0 L104            - z....!..
 0213  95 33 6f 30 2f 1b d4 3f L105            - .3o0/..?
 021b  5c 40 68 3d 7c d9 22 40 L106            - \@h=|."@
 0223  5c 40 68 3d 7c d9 22 40 L107            - \@h=|."@
 022b  95 33 6f 30 2f 1b d4 3f L108            - .3o0/..?
 0233  5c 40 68 3d 7c d9 22 40 L109            - \@h=|."@
 023b  5c 40 68 3d 7c d9 22 40 L110            - \@h=|."@
 0243  95 33 6f 30 2f 1b c4 3f L111            - .3o0/..?
 024b  7a 00 8b fc fa 21 19 40 L112            - z....!.@
 0253  95 33 6f 30 2f 1b c4 3f L113            - .3o0/..?
 025b  7a 00 8b fc fa 21 19 40 L114            - z....!.@
 0263  7a 00 8b fc fa 21 19 c0 L115            - z....!..
 026b  9a 99 99 99 99 99 f1 3f L116            - .......?
 0273  cd cc cc cc cc cc ec 3f L117            - .......?
 027b  54 68 69 73 20 70 72 6f L118            - This pro
 0283  67 72 61 6d 20 72 65 71                 - gram req
 028b  75 69 72 65 73 20 61 20                 - uires a 
 0293  56 45 53 41 20 56 42 45                 - VESA VBE
 029b  20 32 2e 30 20 6f 72 20                 -  2.0 or 
 02a3  68 69 67 68 65 72 20 63                 - higher c
 02ab  6f 6d 70 61 74 69 62 6c                 - ompatibl
 02b3  65 20 53 75 70 65 72 56                 - e SuperV
 02bb  47 41 2e 20 54 72 79 0a                 - GA. Try.
 02c3  00                                      - .
 02c4  69 6e 73 74 61 6c 6c 69 L119            - installi
 02cc  6e 67 20 74 68 65 20 55                 - ng the U
 02d4  6e 69 76 65 72 73 61 6c                 - niversal
 02dc  20 56 45 53 41 20 56 42                 -  VESA VB
 02e4  45 20 66 6f 72 20 79 6f                 - E for yo
 02ec  75 72 20 76 69 64 65 6f                 - ur video
 02f4  20 63 61 72 64 2c 20 6f                 -  card, o
 02fc  72 20 63 6f 6e 74 61 63                 - r contac
 0304  74 20 79 6f 75 72 0a 00                 - t your..
 030c  76 69 64 65 6f 20 63 61 L120            - video ca
 0314  72 64 20 76 65 6e 64 6f                 - rd vendo
 031c  72 20 61 6e 64 20 61 73                 - r and as
 0324  6b 20 66 6f 72 20 61 20                 - k for a 
 032c  73 75 69 74 61 62 6c 65                 - suitable
 0334  20 54 53 52 0a 00                       -  TSR..
 033a  0a 00                   L121            - ..
 033c  45 52 52 4f 52 3a 20 56 L122            - ERROR: V
 0344  69 64 65 6f 20 6d 6f 64                 - ideo mod
 034c  65 20 64 69 64 20 6e 6f                 - e did no
 0354  74 20 73 65 74 20 63 6f                 - t set co
 035c  72 72 65 63 74 6c 79 21                 - rrectly!
 0364  0a 0a 00                                - ...
 0367  0a 50 72 65 73 73 20 61 L123            - .Press a
 036f  6e 79 20 6b 65 79 20 74                 - ny key t
 0377  6f 20 63 6f 6e 74 69 6e                 - o contin
 037f  75 65 2e 2e 2e 0a 00                    - ue.....
 0386  4e 6f 20 4c 69 6e 65 61 L124            - No Linea
 038e  72 20 46 72 61 6d 65 62                 - r Frameb
 0396  75 66 66 65 72 2e 0a 00                 - uffer...
 039e  55 73 61 67 65 3a 20 25 L125            - Usage: %
 03a6  73 20 3c 64 61 74 65 66                 - s <datef
 03ae  69 6c 65 3e 0a 00                       - ile>..
 03b4  0a 53 63 65 6e 65 20 66 L126            - .Scene f
 03bc  69 6c 65 20 6c 6f 61 64                 - ile load
 03c4  65 64 0a 00                             - ed..
 03c8  0a 43 6f 6e 73 74 72 75 L127            - .Constru
 03d0  63 74 69 6e 67 20 42 53                 - cting BS
 03d8  50 20 74 72 65 65 0a 00                 - P tree..
 03e0  0a 42 53 50 20 63 6f 6e L128            - .BSP con
 03e8  73 74 72 75 63 74 69 6f                 - structio
 03f0  6e 20 72 65 61 64 79 2e                 - n ready.
 03f8  0a 00                                   - ..
 03fa  49 6e 20 64 65 6d 6f 2c L129            - In demo,
 0402  20 75 73 65 20 63 75 72                 -  use cur
 040a  73 6f 72 6b 65 79 73 20                 - sorkeys 
 0412  74 6f 20 6d 6f 76 65 2c                 - to move,
 041a  20 3c 65 73 63 61 70 65                 -  <escape
 0422  3e 20 74 6f 20 71 75 69                 - > to qui
 042a  74 2c 0a 00                             - t,..
 042e  3c 63 3e 20 74 6f 20 73 L130            - <c> to s
 0436  68 6f 6f 74 20 61 20 62                 - hoot a b
 043e  61 6c 6c 20 28 6d 61 78                 - all (max
 0446  69 6d 75 6d 20 6f 66 20                 - imum of 
 044e  33 20 62 61 6c 6c 73 29                 - 3 balls)
 0456  0a 00                                   - ..
 0458  3c 70 61 67 65 75 70 2f L131            - <pageup/
 0460  64 6f 77 6e 3e 20 74 6f                 - down> to
 0468  20 6c 6f 6f 6b 20 75 70                 -  look up
 0470  2f 64 6f 77 6e 2c 20 3c                 - /down, <
 0478  68 6f 6d 65 2c 65 6e 64                 - home,end
 0480  3e 20 74 6f 20 72 6f 74                 - > to rot
 0488  61 74 65 20 76 69 65 77                 - ate view
 0490  0a 00                                   - ..
 0492  3c 2b 2c 2d 3e 20 74 6f L132            - <+,-> to
 049a  20 72 65 73 69 7a 65 20                 -  resize 
 04a2  76 69 65 77 77 69 6e 64                 - viewwind
 04aa  6f 77 2c 20 3c 64 3e 20                 - ow, <d> 
 04b2  74 6f 20 72 65 76 65 72                 - to rever
 04ba  73 65 20 67 72 61 76 69                 - se gravi
 04c2  74 79 20 61 6e 64 0a 00                 - ty and..
 04ca  3c 7a 3e 20 74 6f 20 72 L133            - <z> to r
 04d2  65 73 74 6f 72 65 20 6f                 - estore o
 04da  72 69 67 69 6e 61 6c 20                 - riginal 
 04e2  73 65 74 74 69 6e 67 73                 - settings
 04ea  2c 3c 31 2c 32 3e 20 74                 - ,<1,2> t
 04f2  6f 20 63 68 61 6e 67 65                 - o change
 04fa  20 56 69 64 65 6f 6d 6f                 -  Videomo
 0502  64 65 2e 0a 00                          - de...
 0507  3c 66 2c 73 3e 20 74 6f L134            - <f,s> to
 050f  20 63 68 61 6e 67 65 20                 -  change 
 0517  73 70 65 65 64 0a 0a 00                 - speed...
 051f  50 6c 65 61 73 65 20 70 L135            - Please p
 0527  72 65 73 73 20 61 6e 79                 - ress any
 052f  20 6b 65 79 20 74 6f 20                 -  key to 
 0537  76 69 65 77 20 64 65 6d                 - view dem
 053f  6f 2e 0a 00                             - o...
 0543  28 63 29 20 43 6f 70 79 L136            - (c) Copy
 054b  72 69 67 68 74 20 31 39                 - right 19
 0553  39 37 20 45 2e 4a 2e 43                 - 97 E.J.C
 055b  6f 75 6d 61 6e 73 2e 0a                 - oumans..
 0563  00                                      - .
 0564  50 6c 65 61 73 65 20 72 L137            - Please r
 056c  65 70 6f 72 74 20 62 75                 - eport bu
 0574  67 73 20 61 6e 64 20 63                 - gs and c
 057c  6f 6d 6d 65 6e 74 73 20                 - omments 
 0584  74 6f 3a 20 63 6f 6f 63                 - to: cooc
 058c  6b 69 65 40 73 74 61 63                 - kie@stac
 0594  6b 2e 6e 6c 0a 00                       - k.nl..
 059a  79 65 73 20 6c 69 6e 65 L138            - yes line
 05a2  61 72 20 61 74 20 25 69                 - ar at %i
 05aa  00                                      - .
 05ab  6e 6f 20 6c 69 6e 65 61 L139            - no linea
 05b3  72 00                                   - r.

No disassembly errors

------------------------------------------------------------

Segment: _DATA  DWORD USE32  00000028 bytes  
 0000  01 00                   _useLinear      - ..
 0002  00 00                   _ignoreVBE      - ..
 0004  00 00 00 00             _coockieOffset  - ....
 0008  00 00 00 00             _currentMode    - ....
 000c  00 00 00 00             _lastMode       - ....
 0010  00 00 00 00             _frames         - ....
 0014  00 00 0a 00             _vgabuf         - ....
 0018  01 00 00 00             _timercount     - ....
 001c  00 00 00 00             _shooting       - ....
 0020  00 00 00 00             _largerwindow   - ....
 0024  00 00 00 00             _smallerwindow  - ....

No disassembly errors

------------------------------------------------------------

Segment: _BSS  DWORD USE32  00140210 bytes  

No disassembly errors

------------------------------------------------------------

Segment: $$SYMBOLS  BYTE USE16  000005d0 bytes  
 0000  14 12                                   - ..
 0002  00 00 00 00 00 00                       DP      _pcxtextures
 0008  24 70 63 78 74 65 78 74                 - $pcxtext
 0010  75 72 65 73 11 12                       - ures..
 0016  00 00 00 00 00 00                       DP      _modeMenu
 001c  25 6d 6f 64 65 4d 65 6e                 - %modeMen
 0024  75 15 12                                - u..
 0027  00 00 00 00 00 00                       DP      _largerwindow
 002d  09 6c 61 72 67 65 72 77                 - .largerw
 0035  69 6e 64 6f 77 17 12                    - indow..
 003c  00 00 00 00 00 00                       DP      _playerposition
 0042  28 70 6c 61 79 65 72 70                 - (playerp
 004a  6f 73 69 74 69 6f 6e 16                 - osition.
 0052  12                                      - .
 0053  00 00 00 00 00 00                       DP      _smallerwindow
 0059  09 73 6d 61 6c 6c 65 72                 - .smaller
 0061  77 69 6e 64 6f 77 13 12                 - window..
 0069  00 00 00 00 00 00                       DP      _timercount
 006f  09 74 69 6d 65 72 63 6f                 - .timerco
 0077  75 6e 74 0e 12                          - unt..
 007c  00 00 00 00 00 00                       DP      _fname
 0082  12 66 6e 61 6d 65 0f 12                 - .fname..
 008a  00 00 00 00 00 00                       DP      _vgabuf
 0090  12 76 67 61 62 75 66 11                 - .vgabuf.
 0098  12                                      - .
 0099  00 00 00 00 00 00                       DP      _pDIBBase
 009f  12 70 44 49 42 42 61 73                 - .pDIBBas
 00a7  65 0d 12                                - e..
 00aa  00 00 00 00 00 00                       DP      _pDIB
 00b0  12 70 44 49 42 13 12                    - .pDIB..
 00b7  00 00 00 00 00 00                       DP      _semaphore2
 00bd  09 73 65 6d 61 70 68 6f                 - .semapho
 00c5  72 65 32 13 12                          - re2..
 00ca  00 00 00 00 00 00                       DP      _semaphore1
 00d0  09 73 65 6d 61 70 68 6f                 - .semapho
 00d8  72 65 31 11 12                          - re1..
 00dd  00 00 00 00 00 00                       DP      _lastMode
 00e3  09 6c 61 73 74 4d 6f 64                 - .lastMod
 00eb  65 16 12                                - e..
 00ee  00 00 00 00 00 00                       DP      _coockieOffset
 00f4  09 63 6f 6f 63 6b 69 65                 - .coockie
 00fc  4f 66 66 73 65 74 14 12                 - Offset..
 0104  00 00 00 00 00 00                       DP      _currentMode
 010a  09 63 75 72 72 65 6e 74                 - .current
 0112  4d 6f 64 65 13 12                       - Mode..
 0118  00 00 00 00 00 00                       DP      _VBEVersion
 011e  09 56 42 45 56 65 72 73                 - .VBEVers
 0126  69 6f 6e 11 12                          - ion..
 012b  00 00 00 00 00 00                       DP      _shooting
 0131  09 73 68 6f 6f 74 69 6e                 - .shootin
 0139  67 13 12                                - g..
 013c  00 00 00 00 00 00                       DP      _pcxtexture
 0142  29 70 63 78 74 65 78 74                 - )pcxtext
 014a  75 72 65 0f 12                          - ure..
 014f  00 00 00 00 00 00                       DP      _frames
 0155  15 66 72 61 6d 65 73 15                 - .frames.
 015d  12                                      - .
 015e  00 00 00 00 00 00                       DP      _texturestart
 0164  29 74 65 78 74 75 72 65                 - )texture
 016c  73 74 61 72 74 13 12                    - start..
 0173  00 00 00 00 00 00                       DP      _linenumber
 0179  09 6c 69 6e 65 6e 75 6d                 - .linenum
 0181  62 65 72 12 12                          - ber..
 0186  00 00 00 00 00 00                       DP      _useLinear
 018c  22 75 73 65 4c 69 6e 65                 - "useLine
 0194  61 72 12 12                             - ar..
 0198  00 00 00 00 00 00                       DP      _ignoreVBE
 019e  22 69 67 6e 6f 72 65 56                 - "ignoreV
 01a6  42 45 08 32                             - BE.2
 01aa  00 00 00 00 00 00                       DP      _VBE_fatalError
 01b0  23 24 00 00 00 00 33 00                 - #$....3.
 01b8  00 00 00 00 0c 05 10 00                 - ........
 01c0  00 00 2a 00 00 56 42 45                 - ..*..VBE
 01c8  5f 66 61 74 61 6c 45 72                 - _fatalEr
 01d0  72 6f 72 08 11 10 14 12                 - ror.....
 01d8  6d 73 67 2a 24 33 00 00                 - msg*$3..
 01e0  00 7f 00 00 00 00 00 0e                 - ........
 01e8  09 18 00 00 00 2b 30 1c                 - .....+0.
 01f0  00 67 65 74 56 61 6c 69                 - .getVali
 01f8  64 47 72 61 70 68 69 63                 - dGraphic
 0200  73 4d 6f 64 65 0a 11 10                 - sMode...
 0208  f8 2c 6d 6f 64 65 73 08                 - .,modes.
 0210  11 11 f8 fe 30 6d 69 2f                 - ....0mi/
 0218  24 b2 00 00 00 bb 00 00                 - $.......
 0220  00 00 00 0e 09 18 00 00                 - ........
 0228  00 48 00 01 30 1c 42 53                 - .H..0.BS
 0230  50 74 72 61 76 65 72 73                 - Ptravers
 0238  65 54 72 65 65 41 6e 64                 - eTreeAnd
 0240  52 65 6e 64 65 72 0c 11                 - Render..
 0248  10 fc 47 62 73 70 4e 6f                 - ..GbspNo
 0250  64 65 0c 23 cc 03 00 00                 - de.#....
 0258  99 00 00 00 de 02 08 11                 - ........
 0260  11 0c ff 26 78 78 08 11                 - ...&xx..
 0268  11 10 ff 26 79 79 08 11                 - ...&yy..
 0270  11 14 ff 26 7a 7a 08 11                 - ...&zz..
 0278  11 18 ff 26 75 75 08 11                 - ...&uu..
 0280  11 1c ff 26 76 76 0c 23                 - ...&vv.#
 0288  73 04 00 00 4a 00 00 00                 - s...J...
 0290  de 02 08 11 11 00 ff 26                 - .......&
 0298  78 78 08 11 11 04 ff 26                 - xx.....&
 02a0  79 79 08 11 11 08 ff 26                 - yy.....&
 02a8  7a 7a 0c 23 cf 04 00 00                 - zz.#....
 02b0  85 00 00 00 de 02 08 11                 - ........
 02b8  11 ec fe 26 78 78 08 11                 - ...&xx..
 02c0  11 f0 fe 26 79 79 08 11                 - ...&yy..
 02c8  11 f4 fe 26 7a 7a 08 11                 - ...&zz..
 02d0  11 f8 fe 26 75 75 08 11                 - ...&uu..
 02d8  11 fc fe 26 76 76 23 24                 - ...&vv#$
 02e0  6d 01 00 00 bf 09 00 00                 - m.......
 02e8  00 00 0c 07 10 00 00 00                 - ........
 02f0  4c 00 03 30 1c 30 1f 30                 - L..0.0.0
 02f8  1d 67 65 74 53 63 65 6e                 - .getScen
 0300  65 0d 11 10 ac 49 66 69                 - e....Ifi
 0308  6c 65 4e 61 6d 65 0d 11                 - leName..
 0310  10 cc 4a 70 6f 73 69 74                 - ..Jposit
 0318  69 6f 6e 0a 11 10 d0 4b                 - ion....K
 0320  66 4c 69 73 74 0b 11 10                 - fList...
 0328  98 28 63 65 6e 74 65 72                 - .(center
 0330  0e 11 10 b0 09 74 65 78                 - .....tex
 0338  61 64 72 65 73 31 0c 11                 - adres1..
 0340  10 a4 4e 6d 69 6e 5f 73                 - ..Nmin_s
 0348  65 63 07 11 10 b4 52 66                 - ec....Rf
 0350  68 0a 11 10 bc 09 57 69                 - h.....Wi
 0358  64 74 68 0b 11 10 e8 09                 - dth.....
 0360  48 65 69 67 68 74 0e 11                 - Height..
 0368  10 b8 12 50 43 58 42 75                 - ...PCXBu
 0370  66 66 65 72 13 11 10 f0                 - ffer....
 0378  09 61 61 6e 74 61 6c 74                 - .aantalt
 0380  65 78 74 75 72 65 73 10                 - extures.
 0388  11 10 c0 3e 6d 6f 76 69                 - ...>movi
 0390  6e 67 66 4c 69 73 74 0e                 - ngfList.
 0398  11 10 c4 3e 66 4c 69 73                 - ...>fLis
 03a0  74 54 61 69 6c 14 11 10                 - tTail...
 03a8  c8 3e 6d 6f 76 69 6e 67                 - .>moving
 03b0  66 4c 69 73 74 54 61 69                 - fListTai
 03b8  6c 0b 11 11 50 ff 38 74                 - l...P.8t
 03c0  72 79 79 79 11 11 11 28                 - ryyy...(
 03c8  ff 38 6d 6f 76 69 6e 67                 - .8moving
 03d0  74 72 79 79 79 0a 11 10                 - tryyy...
 03d8  d4 39 76 4c 69 73 74 0e                 - .9vList.
 03e0  11 10 d8 39 76 4c 69 73                 - ...9vLis
 03e8  74 54 61 69 6c 10 11 10                 - tTail...
 03f0  dc 39 6d 6f 76 69 6e 67                 - .9moving
 03f8  76 4c 69 73 74 14 11 10                 - vList...
 0400  e0 39 6d 6f 76 69 6e 67                 - .9moving
 0408  76 4c 69 73 74 54 61 69                 - vListTai
 0410  6c 10 11 21                             - l..!
 0414  c0 01 14 00 00 00                       DP      DGROUP:L140
 041a  53 62 75 66 66 65 72 0a                 - Sbuffer.
 0422  11 10 e4 1b 63 6f 6c 6f                 - ....colo
 042a  72 0a 11 10 88 36 70 6c                 - r....6pl
 0432  61 6e 65 10 11 10 ec 1b                 - ane.....
 043a  6d 6f 76 69 6e 67 63 6f                 - movingco
 0442  6c 6f 72 11 11 11 78 ff                 - lor...x.
 044a  36 6d 6f 76 69 6e 67 70                 - 6movingp
 0452  6c 61 6e 65 10 11 10 f4                 - lane....
 045a  09 6f 62 6a 65 63 74 73                 - .objects
 0462  72 65 61 64 12 11 10 f8                 - read....
 046a  09 6d 6f 76 69 6e 67 73                 - .movings
 0472  70 65 63 69 61 6c 07 11                 - pecial..
 047a  10 fc 52 66 70 1e 24 2c                 - ..Rfp.$,
 0482  0b 00 00 33 00 00 00 00                 - ...3....
 048a  00 0e 09 18 00 00 00 54                 - .......T
 0492  00 01 30 1c 73 65 74 6d                 - ..0.setm
 049a  6f 64 65 06 11 10 fc 08                 - ode.....
 04a2  6e 0b 11 10 c4 5c 69 6e                 - n....\in
 04aa  72 65 67 73 0c 11 10 e0                 - regs....
 04b2  5c 6f 75 74 72 65 67 73                 - \outregs
 04ba  1e 24 5f 0b 00 00 a1 04                 - .$_.....
 04c2  00 00 00 00 0e 09 18 00                 - ........
 04ca  00 00 0f 00 00 43 68 65                 - .....Che
 04d2  63 6b 4b 65 79 73 25 24                 - ckKeys%$
 04da  00 10 00 00 0a 01 00 00                 - ........
 04e2  00 00 0e 09 18 00 00 00                 - ........
 04ea  5d 00 01 30 1c 63 6f 6f                 - ]..0.coo
 04f2  63 6b 69 65 53 45 54 4d                 - ckieSETM
 04fa  4f 44 45 0c 11 10 fc 09                 - ODE.....
 0502  56 42 45 4d 6f 64 65 08                 - VBEMode.
 050a  11 11 fc fe 30 6d 69 24                 - ....0mi$
 0512  24 0a 11 00 00 c6 01 00                 - $.......
 051a  00 00 00 0e 09 18 00 00                 - ........
 0522  00 5e 00 00 63 6f 6f 63                 - .^..cooc
 052a  6b 69 65 56 42 45 5f 49                 - kieVBE_I
 0532  4e 49 54 0c 11 10 f4 09                 - NIT.....
 053a  63 6f 6f 63 6b 69 65 0a                 - coockie.
 0542  11 10 f8 2c 6d 6f 64 65                 - ...,mode
 054a  73 0d 11 10 fc 1e 76 65                 - s.....ve
 0552  73 61 6d 6f 64 65 08 11                 - samode..
 055a  11 f4 fe 30 6d 69 1e 24                 - ...0mi.$
 0562  d0 12 00 00 b3 02 00 00                 - ........
 056a  00 00 0d 08 14 00 00 00                 - ........
 0572  60 30 1c 02 30 1c 30 1f                 - `0..0.0.
 057a  6d 61 69 6e 09 11 10 f0                 - main....
 0582  09 61 72 67 63 09 11 10                 - .argc...
 058a  f4 5f 61 72 67 76 0c 11                 - ._argv..
 0592  10 f8 09 63 6f 6f 63 6b                 - ...coock
 059a  69 65 0d 11 10 ec 3e 66                 - ie....>f
 05a2  61 63 65 4c 69 73 74 0b                 - aceList.
 05aa  11 10 c8 28 63 65 6e 74                 - ...(cent
 05b2  65 72 10 11 10 d4 28 6f                 - er....(o
 05ba  6c 64 50 6f 73 69 74 69                 - ldPositi
 05c2  6f 6e 0c 11 10 e0 63 73                 - on....cs
 05ca  61 76 65 70 6f 73                       - avepos

No disassembly errors

------------------------------------------------------------

Segment: $$TYPES  BYTE USE16  0000078f bytes  
 0000  06 13 8f 07 00 00 08 11                 - ........
 0008  73 74 72 75 63 74 07 11                 - struct..
 0010  75 6e 69 6f 6e 06 11 65                 - union..e
 0018  6e 75 6d 07 10 10 63 68                 - num...ch
 0020  61 72 0e 10 00 73 69 67                 - ar...sig
 0028  6e 65 64 20 63 68 61 72                 - ned char
 0030  10 10 10 75 6e 73 69 67                 - ...unsig
 0038  6e 65 64 20 63 68 61 72                 - ned char
 0040  08 10 01 73 68 6f 72 74                 - ...short
 0048  11 10 11 75 6e 73 69 67                 - ...unsig
 0050  6e 65 64 20 73 68 6f 72                 - ned shor
 0058  74 06 10 03 69 6e 74 0f                 - t...int.
 0060  10 13 75 6e 73 69 67 6e                 - ..unsign
 0068  65 64 20 69 6e 74 0b 12                 - ed int..
 0070  00 08 77 63 68 61 72 5f                 - ..wchar_
 0078  74 0a 12 00 0a 73 69 7a                 - t....siz
 0080  65 5f 74 0b 12 00 08 77                 - e_t....w
 0088  63 68 61 72 5f 74 07 10                 - char_t..
 0090  30 76 6f 69 64 04 72 0e                 - 0void.r.
 0098  00 03 46 0f 0c 12 00 10                 - ..F.....
 00a0  6f 6e 65 78 69 74 5f 74                 - onexit_t
 00a8  03 46 04 04 20 00 12 0d                 - .F.. ...
 00b0  12 00 13 5f 5f 76 61 5f                 - ...__va_
 00b8  6c 69 73 74 07 10 03 6c                 - list...l
 00c0  6f 6e 67 0a 12 00 15 66                 - ong....f
 00c8  70 6f 73 5f 74 0a 12 00                 - pos_t...
 00d0  15 66 70 6f 73 5f 74 0d                 - .fpos_t.
 00d8  12 00 09 70 74 72 64 69                 - ...ptrdi
 00e0  66 66 5f 74 0b 12 00 09                 - ff_t....
 00e8  62 6f 6f 6c 65 61 6e 08                 - myboolean.
 00f0  12 00 19 66 6c 61 67 09                 - ...flag.
 00f8  12 00 09 43 4f 4c 4f 52                 - ...COLOR
 0100  09 12 00 09 43 4f 4c 4f                 - ....COLO
 0108  52 09 12 00 06 75 63 68                 - R....uch
 0110  61 72 0a 12 00 08 75 73                 - ar....us
 0118  68 6f 72 74 08 12 00 0a                 - hort....
 0120  75 69 6e 74 10 10 13 75                 - uint...u
 0128  6e 73 69 67 6e 65 64 20                 - nsigned 
 0130  6c 6f 6e 67 09 12 00 20                 - long... 
 0138  75 6c 6f 6e 67 08 12 00                 - ulong...
 0140  07 62 6f 6f 6c 07 22 ff                 - .bool.".
 0148  ff 00 00 06 04 20 13 23                 - ..... .#
 0150  04 20 63 09 08 10 23 66                 - . c...#f
 0158  6c 6f 61 74 08 60 03 00                 - loat.`..
 0160  0c 00 00 00 06 61 08 26                 - .....a.&
 0168  7a 7a 06 61 04 26 79 79                 - zz.a.&yy
 0170  06 61 00 26 78 78 09 12                 - .a.&xx..
 0178  00 27 50 4f 49 4e 54 03                 - .'OLDPOINT.
 0180  46 06 05 72 0e 01 12 05                 - F..r....
 0188  72 09 01 0e 03 46 1e 03                 - r....F..
 0190  46 0e 05 21 cd 00 04 08                 - F..!....
 0198  60 21 00 00 01 00 00 08                 - `!......
 01a0  61 32 2e 72 65 73 32 14                 - a2.res2.
 01a8  61 30 07 4f 66 66 53 63                 - a0.OffSc
 01b0  72 65 65 6e 4d 65 6d 53                 - reenMemS
 01b8  69 7a 65 16 61 2c 21 4f                 - ize.a,!O
 01c0  66 66 53 63 72 65 65 6e                 - ffScreen
 01c8  4d 65 6d 4f 66 66 73 65                 - MemOffse
 01d0  74 0f 61 28 21 50 68 79                 - t.a(!Phy
 01d8  73 42 61 73 65 50 74 72                 - sBasePtr
 01e0  17 61 27 04 44 69 72 65                 - .a'.Dire
 01e8  63 74 43 6f 6c 6f 72 4d                 - ctColorM
 01f0  6f 64 65 49 6e 66 6f 15                 - odeInfo.
 01f8  61 26 04 52 73 76 64 46                 - a&.RsvdF
 0200  69 65 6c 64 50 6f 73 69                 - ieldPosi
 0208  74 69 6f 6e 10 61 25 04                 - tion.a%.
 0210  52 73 76 64 4d 61 73 6b                 - RsvdMask
 0218  53 69 7a 65 15 61 24 04                 - Size.a$.
 0220  42 6c 75 65 46 69 65 6c                 - BlueFiel
 0228  64 50 6f 73 69 74 69 6f                 - dPositio
 0230  6e 10 61 23 04 42 6c 75                 - n.a#.Blu
 0238  65 4d 61 73 6b 53 69 7a                 - eMaskSiz
 0240  65 16 61 22 04 47 72 65                 - e.a".Gre
 0248  65 6e 46 69 65 6c 64 50                 - enFieldP
 0250  6f 73 69 74 69 6f 6e 11                 - osition.
 0258  61 21 04 47 72 65 65 6e                 - a!.Green
 0260  4d 61 73 6b 53 69 7a 65                 - MaskSize
 0268  14 61 20 04 52 65 64 46                 - .a .RedF
 0270  69 65 6c 64 50 6f 73 69                 - ieldPosi
 0278  74 69 6f 6e 0f 61 1f 04                 - tion.a..
 0280  52 65 64 4d 61 73 6b 53                 - RedMaskS
 0288  69 7a 65 08 61 1e 04 72                 - ize.a..r
 0290  65 73 31 16 61 1d 04 4e                 - es1.a..N
 0298  75 6d 62 65 72 4f 66 49                 - umberOfI
 02a0  6d 61 67 65 50 61 67 65                 - magePage
 02a8  73 0c 61 1c 04 42 61 6e                 - s.a..Ban
 02b0  6b 53 69 7a 65 0f 61 1b                 - kSize.a.
 02b8  04 4d 65 6d 6f 72 79 4d                 - .MemoryM
 02c0  6f 64 65 6c 11 61 1a 04                 - odel.a..
 02c8  4e 75 6d 62 65 72 4f 66                 - NumberOf
 02d0  42 61 6e 6b 73 10 61 19                 - Banks.a.
 02d8  04 42 69 74 73 50 65 72                 - .BitsPer
 02e0  50 69 78 65 6c 12 61 18                 - Pixel.a.
 02e8  04 4e 75 6d 62 65 72 4f                 - .NumberO
 02f0  66 50 6c 61 6e 65 73 0d                 - fPlanes.
 02f8  61 17 04 59 43 68 61 72                 - a..YChar
 0300  53 69 7a 65 0d 61 16 04                 - Size.a..
 0308  58 43 68 61 72 53 69 7a                 - XCharSiz
 0310  65 0f 61 14 07 59 52 65                 - e.a..YRe
 0318  73 6f 6c 75 74 69 6f 6e                 - solution
 0320  0f 61 12 07 58 52 65 73                 - .a..XRes
 0328  6f 6c 75 74 69 6f 6e 14                 - olution.
 0330  61 10 07 42 79 74 65 73                 - a..Bytes
 0338  50 65 72 53 63 61 6e 4c                 - PerScanL
 0340  69 6e 65 0e 61 0c 2d 57                 - ine.a.-W
 0348  69 6e 46 75 6e 63 50 74                 - inFuncPt
 0350  72 0f 61 0a 07 57 69 6e                 - r.a..Win
 0358  42 53 65 67 6d 65 6e 74                 - BSegment
 0360  0f 61 08 07 57 69 6e 41                 - .a..WinA
 0368  53 65 67 6d 65 6e 74 0b                 - Segment.
 0370  61 06 07 57 69 6e 53 69                 - a..WinSi
 0378  7a 65 12 61 04 07 57 69                 - ze.a..Wi
 0380  6e 47 72 61 6e 75 6c 61                 - nGranula
 0388  72 69 74 79 12 61 03 04                 - rity.a..
 0390  57 69 6e 42 41 74 74 72                 - WinBAttr
 0398  69 62 75 74 65 73 12 61                 - ibutes.a
 03a0  02 04 57 69 6e 41 41 74                 - ..WinAAt
 03a8  74 72 69 62 75 74 65 73                 - tributes
 03b0  12 61 00 07 4d 6f 64 65                 - .a..Mode
 03b8  41 74 74 72 69 62 75 74                 - Attribut
 03c0  65 73 10 12 00 2f 56 42                 - es.../VB
 03c8  45 5f 6d 6f 64 65 49 6e                 - E_modeIn
 03d0  66 6f 05 50 03 00 10 0b                 - fo.P....
 03d8  51 6f 4f 55 54 5f 4e 4f                 - QoOUT_NO
 03e0  44 45 0a 51 69 49 4e 5f                 - DE.QiIN_
 03e8  4e 4f 44 45 11 51 70 50                 - NODE.QpP
 03f0  41 52 54 49 54 49 4f 4e                 - ARTITION
 03f8  5f 4e 4f 44 45 0d 12 00                 - _NODE...
 0400  31 4e 4f 44 45 5f 54 59                 - 1NODE_TY
 0408  50 45 0e 12 01 80 37 76                 - PE....7v
 0410  65 72 74 65 78 54 61 67                 - ertexTag
 0418  03 46 33 08 60 04 00 10                 - .F3.`...
 0420  00 00 00 06 61 0c 26 64                 - ....a.&d
 0428  64 06 61 08 26 63 63 06                 - d.a.&cc.
 0430  61 04 26 62 62 06 61 00                 - a.&bb.a.
 0438  26 61 61 09 12 00 35 50                 - &aa...5P
 0440  4c 41 4e 45 08 60 07 00                 - LANE.`..
 0448  28 00 00 00 09 61 18 36                 - (....a.6
 0450  70 6c 61 6e 65 09 61 14                 - plane.a.
 0458  34 76 6e 65 78 74 06 61                 - 4vnext.a
 0460  10 26 76 76 06 61 0c 26                 - .&vv.a.&
 0468  75 75 06 61 08 26 7a 7a                 - uu.a.&zz
 0470  06 61 04 26 79 79 06 61                 - .a.&yy.a
 0478  00 26 78 78 0a 12 00 33                 - .&xx...3
 0480  56 45 52 54 45 58 03 46                 - VERTEX.F
 0488  38 0c 12 01 80 3c 66 61                 - 8....<fa
 0490  63 65 54 61 67 03 46 3a                 - ceTag.F:
 0498  08 60 08 00 98 00 00 00                 - .`......
 04a0  09 61 94 3b 66 6e 65 78                 - .a.;fnex
 04a8  74 09 61 84 36 70 6c 61                 - t.a.6pla
 04b0  6e 65 09 61 80 39 76 68                 - ne.a.9vh
 04b8  65 61 64 0c 61 7c 09 62                 - ead.a|.b
 04c0  73 70 64 65 70 74 68 05                 - spdepth.
 04c8  61 54 38 4e 05 61 2c 38                 - aT8N.a,8
 04d0  4d 05 61 04 38 50 09 61                 - M.a.8P.a
 04d8  00 1b 63 6f 6c 6f 72 08                 - ..color.
 04e0  12 00 3a 46 41 43 45 03                 - ..:FACE.
 04e8  46 3d 0f 12 01 80 45 62                 - F=....Eb
 04f0  73 70 6e 6f 64 65 54 61                 - spnodeTa
 04f8  67 03 46 3f 08 60 04 00                 - g.F?.`..
 0500  10 00 00 00 10 61 0c 40                 - .....a.@
 0508  70 6f 73 69 74 69 76 65                 - positive
 0510  53 69 64 65 10 61 08 40                 - Side.a.@
 0518  6e 65 67 61 74 69 76 65                 - negative
 0520  53 69 64 65 0a 61 04 3e                 - Side.a.>
 0528  6f 70 70 44 69 72 0b 61                 - oppDir.a
 0530  00 3e 73 61 6d 65 44 69                 - .>sameDi
 0538  72 14 12 01 41 70 61 72                 - r...Apar
 0540  74 69 74 69 6f 6e 6e 6f                 - titionno
 0548  64 65 54 61 67 11 12 00                 - deTag...
 0550  42 50 41 52 54 49 54 49                 - BPARTITI
 0558  4f 4e 4e 4f 44 45 03 46                 - ONNODE.F
 0560  43 08 60 02 00 05 00 00                 - C.`.....
 0568  00 08 61 01 44 6e 6f 64                 - ..a.Dnod
 0570  65 08 61 00 32 6b 69 6e                 - e.a.2kin
 0578  64 0b 12 00 3f 42 53 50                 - d...?BSP
 0580  4e 4f 44 45 03 46 46 05                 - NODE.FF.
 0588  72 0e 01 47 03 46 04 03                 - r..G.F..
 0590  46 28 03 46 3e 07 72 0e                 - F(.F>.r.
 0598  03 49 4a 4b 08 60 02 00                 - .IJK.`..
 05a0  08 00 00 00 07 61 04 09                 - .....a..
 05a8  72 65 6d 08 61 00 09 71                 - rem.a..q
 05b0  75 6f 74 09 12 00 4d 64                 - uot...Md
 05b8  69 76 5f 74 08 60 08 00                 - iv_t.`..
 05c0  1a 00 00 00 0d 61 19 06                 - .....a..
 05c8  5f 74 6d 70 66 63 68 61                 - _tmpfcha
 05d0  72 0d 61 18 06 5f 75 6e                 - r.a.._un
 05d8  67 6f 74 74 65 6e 0c 61                 - gotten.a
 05e0  14 0a 5f 62 75 66 73 69                 - .._bufsi
 05e8  7a 65 0b 61 10 09 5f 68                 - ze.a.._h
 05f0  61 6e 64 6c 65 09 61 0c                 - andle.a.
 05f8  0a 5f 66 6c 61 67 09 61                 - ._flag.a
 0600  08 29 5f 62 61 73 65 08                 - .)_base.
 0608  61 04 09 5f 63 6e 74 08                 - a.._cnt.
 0610  61 00 29 5f 70 74 72 0b                 - a.)_ptr.
 0618  12 01 4f 5f 5f 69 6f 62                 - ..O__iob
 0620  75 66 08 12 00 50 46 49                 - uf...PFI
 0628  4c 45 03 46 51 04 20 4f                 - LE.FQ. O
 0630  04 05 72 0e 01 08 08 60                 - ..r....`
 0638  07 00 1c 00 00 00 09 61                 - .......a
 0640  18 0a 63 66 6c 61 67 07                 - ..cflag.
 0648  61 14 0a 65 64 69 07 61                 - a..edi.a
 0650  10 0a 65 73 69 07 61 0c                 - ..esi.a.
 0658  0a 65 64 78 07 61 08 0a                 - .edx.a..
 0660  65 63 78 07 61 04 0a 65                 - ecx.a..e
 0668  62 78 07 61 00 0a 65 61                 - bx.a..ea
 0670  78 0d 12 01 55 44 57 4f                 - x...UDWO
 0678  52 44 52 45 47 53 08 60                 - RDREGS.`
 0680  0d 00 1c 00 00 00 09 61                 - .......a
 0688  18 0a 63 66 6c 61 67 06                 - ..cflag.
 0690  61 16 08 5f 36 06 61 14                 - a.._6.a.
 0698  08 64 69 06 61 12 08 5f                 - .di.a.._
 06a0  35 06 61 10 08 73 69 06                 - 5.a..si.
 06a8  61 0e 08 5f 34 06 61 0c                 - a.._4.a.
 06b0  08 64 78 06 61 0a 08 5f                 - .dx.a.._
 06b8  33 06 61 08 08 63 78 06                 - 3.a..cx.
 06c0  61 06 08 5f 32 06 61 04                 - a.._2.a.
 06c8  08 62 78 06 61 02 08 5f                 - .bx.a.._
 06d0  31 06 61 00 08 61 78 0c                 - 1.a..ax.
 06d8  12 01 57 57 4f 52 44 52                 - ..WWORDR
 06e0  45 47 53 08 60 0c 00 10                 - EGS.`...
 06e8  00 00 00 06 61 0e 08 5f                 - ....a.._
 06f0  34 06 61 0d 06 64 68 06                 - 4.a..dh.
 06f8  61 0c 06 64 6c 06 61 0a                 - a..dl.a.
 0700  08 5f 33 06 61 09 06 63                 - ._3.a..c
 0708  68 06 61 08 06 63 6c 06                 - h.a..cl.
 0710  61 06 08 5f 32 06 61 05                 - a.._2.a.
 0718  06 62 68 06 61 04 06 62                 - .bh.a..b
 0720  6c 06 61 02 08 5f 31 06                 - l.a.._1.
 0728  61 01 06 61 68 06 61 00                 - a..ah.a.
 0730  06 61 6c 0c 12 01 59 42                 - .al...YB
 0738  59 54 45 52 45 47 53 08                 - YTEREGS.
 0740  60 03 00 1c 00 00 00 05                 - `.......
 0748  61 00 5a 68 05 61 00 58                 - a.Zh.a.X
 0750  77 05 61 00 56 78 08 12                 - w.a.Vx..
 0758  02 5b 52 45 47 53 05 72                 - .[REGS.r
 0760  0e 01 09 05 72 0e 01 0e                 - ....r...
 0768  03 46 12 06 72 09 02 09                 - .F..r...
 0770  5f 04 20 02 26 08 60 01                 - _. .&.`.
 0778  00 0c 00 00 00 05 61 00                 - ......a.
 0780  61 76 0b 12 00 62 70 6f                 - av...bpo
 0788  69 6e 74 5f 74 02 14                    - int_t..

No disassembly errors

------------------------------------------------------------

Segment: $$TYPES  BYTE USE16  000002e4 bytes  
 0000  00 00 1a 00 00 00 20 00                 - ...... .
 0008  3e 00 53 00 67 00 79 00                 - >.S.g.y.
 0010  8e 00 a2 00 c3 00 d5 00                 - ........
 0018  e7 00 f9 00 0c 01 21 01                 - ......!.
 0020  3f 01 54 01 74 01 97 01                 - ?.T.t...
 0028  b4 01 d3 01 f3 01 15 02                 - ........
 0030  36 02 58 02 77 02 98 02                 - 6.X.w...
 0038  44 3a 5c 43 4f 44 49 4e                 - D:\CODIN
 0040  47 5c 45 4e 47 49 4e 45                 - G\ENGINE
 0048  5c 30 33 30 36 39 37 5c                 - \030697\
 0050  77 6d 61 69 6e 2e 63 00                 - wmain.c.
 0058  44 3a 5c 43 4f 44 49 4e                 - D:\CODIN
 0060  47 5c 45 4e 47 49 4e 45                 - G\ENGINE
 0068  5c 30 33 30 36 39 37 5c                 - \030697\
 0070  70 63 78 2e 68 00 64 3a                 - pcx.h.d:
 0078  5c 77 61 74 63 6f 6d 5c                 - \watcom\
 0080  48 5c 73 74 64 6c 69 62                 - H\stdlib
 0088  2e 68 00 64 3a 5c 77 61                 - .h.d:\wa
 0090  74 63 6f 6d 5c 48 5c 73                 - tcom\H\s
 0098  74 64 69 6f 2e 68 00 64                 - tdio.h.d
 00a0  3a 5c 77 61 74 63 6f 6d                 - :\watcom
 00a8  5c 48 5c 6d 65 6d 2e 68                 - \H\mem.h
 00b0  00 64 3a 5c 77 61 74 63                 - .d:\watc
 00b8  6f 6d 5c 48 5c 73 74 72                 - om\H\str
 00c0  69 6e 67 2e 68 00 64 3a                 - ing.h.d:
 00c8  5c 77 61 74 63 6f 6d 5c                 - \watcom\
 00d0  48 5c 63 6f 6e 69 6f 2e                 - H\conio.
 00d8  68 00 44 3a 5c 43 4f 44                 - h.D:\COD
 00e0  49 4e 47 5c 45 4e 47 49                 - ING\ENGI
 00e8  4e 45 5c 30 33 30 36 39                 - NE\03069
 00f0  37 5c 67 6c 6f 62 61 6c                 - 7\global
 00f8  2e 68 00 64 3a 5c 77 61                 - .h.d:\wa
 0100  74 63 6f 6d 5c 48 5c 49                 - tcom\H\I
 0108  38 36 2e 68 00 64 3a 5c                 - 86.h.d:\
 0110  77 61 74 63 6f 6d 5c 48                 - watcom\H
 0118  5c 64 6f 73 2e 68 00 64                 - \dos.h.d
 0120  3a 5c 77 61 74 63 6f 6d                 - :\watcom
 0128  5c 48 5c 69 38 36 2e 68                 - \H\i86.h
 0130  00 64 3a 5c 77 61 74 63                 - .d:\watc
 0138  6f 6d 5c 48 5c 6d 61 74                 - om\H\mat
 0140  68 2e 68 00 64 3a 5c 77                 - h.h.d:\w
 0148  61 74 63 6f 6d 5c 48 5c                 - atcom\H\
 0150  6d 61 6c 6c 6f 63 2e 68                 - malloc.h
 0158  00 44 3a 5c 43 4f 44 49                 - .D:\CODI
 0160  4e 47 5c 45 4e 47 49 4e                 - NG\ENGIN
 0168  45 5c 30 33 30 36 39 37                 - E\030697
 0170  5c 62 73 70 2e 68 00 64                 - \bsp.h.d
 0178  3a 5c 77 61 74 63 6f 6d                 - :\watcom
 0180  5c 48 5c 61 73 73 65 72                 - \H\asser
 0188  74 2e 68 00 44 3a 5c 43                 - t.h.D:\C
 0190  4f 44 49 4e 47 5c 45 4e                 - ODING\EN
 0198  47 49 4e 45 5c 30 33 30                 - GINE\030
 01a0  36 39 37 5c 67 67 65 6d                 - 697\ggem
 01a8  73 2e 68 00 44 3a 5c 43                 - s.h.D:\C
 01b0  4f 44 49 4e 47 5c 45 4e                 - ODING\EN
 01b8  47 49 4e 45 5c 30 33 30                 - GINE\030
 01c0  36 39 37 5c 6b 65 79 62                 - 697\keyb
 01c8  6f 61 72 64 2e 68 00 44                 - oard.h.D
 01d0  3a 5c 43 4f 44 49 4e 47                 - :\CODING
 01d8  5c 45 4e 47 49 4e 45 5c                 - \ENGINE\
 01e0  30 33 30 36 39 37 5c 33                 - 030697\3
 01e8  64 2e 68 00 44 3a 5c 43                 - d.h.D:\C
 01f0  4f 44 49 4e 47 5c 45 4e                 - ODING\EN
 01f8  47 49 4e 45 5c 30 33 30                 - GINE\030
 0200  36 39 37 5c 73 76 67 61                 - 697\svga
 0208  2e 68 00 44 3a 5c 43 4f                 - .h.D:\CO
 0210  44 49 4e 47 5c 45 4e 47                 - DING\ENG
 0218  49 4e 45 5c 30 33 30 36                 - INE\0306
 0220  39 37 5c 64 65 62 75 67                 - 97\debug
 0228  2e 68 00 44 3a 5c 43 4f                 - .h.D:\CO
 0230  44 49 4e 47 5c 45 4e 47                 - DING\ENG
 0238  49 4e 45 5c 30 33 30 36                 - INE\0306
 0240  39 37 5c 76 65 73 61 76                 - 97\vesav
 0248  62 65 2e 68 00 44 3a 5c                 - be.h.D:\
 0250  43 4f 44 49 4e 47 5c 45                 - CODING\E
 0258  4e 47 49 4e 45 5c 30 33                 - NGINE\03
 0260  30 36 39 37 5c 33 64 6d                 - 0697\3dm
 0268  61 74 68 2e 68 00 44 3a                 - ath.h.D:
 0270  5c 43 4f 44 49 4e 47 5c                 - \CODING\
 0278  45 4e 47 49 4e 45 5c 30                 - ENGINE\0
 0280  33 30 36 39 37 5c 63 6f                 - 30697\co
 0288  6c 6c 69 64 65 2e 68 00                 - llide.h.
 0290  44 3a 5c 43 4f 44 49 4e                 - D:\CODIN
 0298  47 5c 45 4e 47 49 4e 45                 - G\ENGINE
 02a0  5c 30 33 30 36 39 37 5c                 - \030697\
 02a8  6d 6f 76 65 2e 68 00 44                 - move.h.D
 02b0  3a 5c 43 4f 44 49 4e 47                 - :\CODING
 02b8  5c 45 4e 47 49 4e 45 5c                 - \ENGINE\
 02c0  30 33 30 36 39 37 5c 6f                 - 030697\o
 02c8  62 6a 65 63 74 2e 68 00                 - bject.h.
 02d0  64 3a 5c 77 61 74 63 6f                 - d:\watco
 02d8  6d 5c 48 5c 67 72 61 70                 - m\H\grap
 02e0  68 2e 68 00                             - h.h.

No disassembly errors

------------------------------------------------------------
