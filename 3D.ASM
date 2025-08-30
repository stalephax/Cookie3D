.386p
                NAME    3d
                EXTRN   __8087 :BYTE
                EXTRN   __init_387_emulator :BYTE
                EXTRN   _fltused_ :BYTE
                EXTRN   vectoradd_ :BYTE
                EXTRN   vectorscalar_ :BYTE
                EXTRN   sqrt_ :BYTE
                EXTRN   exit_ :BYTE
                EXTRN   printf_ :BYTE
                EXTRN   cos_ :BYTE
                EXTRN   sin_ :BYTE
                EXTRN   atan_ :BYTE
                EXTRN   _SV_clear :BYTE
                EXTRN   _modeMenu :BYTE
                EXTRN   _currentMode :BYTE
                EXTRN   _gravitationaccel :BYTE
                EXTRN   _gravitationspeed :BYTE
                EXTRN   DotProduct_ :BYTE
                EXTRN   CrossvProduct_ :BYTE
                EXTRN   vectorsubtract_ :BYTE
                EXTRN   memset_ :BYTE
                EXTRN   _pcxtexture :BYTE
                EXTRN   _texturestart :BYTE
                EXTRN   __CHP :BYTE
                EXTRN   ceil_ :BYTE
                EXTRN   VBE_getLinearSelector_ :BYTE
DGROUP          GROUP   CONST,CONST2,_DATA,_BSS
_TEXT           SEGMENT BYTE PUBLIC USE32 'CODE'
                ASSUME  CS:_TEXT ,DS:DGROUP,SS:DGROUP
                PUBLIC  coockie_getLinearSelector_ 
                PUBLIC  AddPolygonEdges_ 
                PUBLIC  VBE_DrawSpans_ 
                PUBLIC  VGA_DrawSpans_ 
                PUBLIC  ScanEdges_ 
                PUBLIC  ClearEdgeLists_ 
                PUBLIC  addpolygon_ 
                PUBLIC  InitPos_ 
                PUBLIC  InitDraw_ 
                PUBLIC  UpdateDraw_ 
                PUBLIC  ProjectPolygon_ 
                PUBLIC  BackRotateVector_ 
                PUBLIC  TransformPoint_ 
                PUBLIC  TransformvPoint_ 
                PUBLIC  TransformPolygon_ 
                PUBLIC  PolyFacesViewer_ 
                PUBLIC  SetWorldspaceClipPlane_ 
                PUBLIC  SetUpFrustum_ 
                PUBLIC  ClipToPlane_ 
                PUBLIC  ClipToFrustum_ 
                PUBLIC  computePMN_ 
                PUBLIC  ComputeMagic_ 
                PUBLIC  drawFaceList_ 
coockie_getLinearSelector_:
                push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000008H
                mov     dword ptr -8H[ebp],eax
                mov     eax,dword ptr -8H[ebp]
                call    near ptr VBE_getLinearSelector_
                mov     word ptr L255,ax
                mov     ax,word ptr L255
                mov     dword ptr -4H[ebp],eax
                mov     eax,dword ptr -4H[ebp]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
AddPolygonEdges_:
                push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000068H
                mov     dword ptr -40H[ebp],eax
                mov     dword ptr -44H[ebp],edx
                mov     eax,dword ptr -44H[ebp]
                mov     eax,dword ptr [eax]
                mov     dword ptr -34H[ebp],eax
                mov     dword ptr -3cH[ebp],00000000H
L1:             mov     eax,dword ptr -3cH[ebp]
                cmp     eax,dword ptr -34H[ebp]
                jl      short L3
                jmp     near ptr L8
L2:             mov     eax,dword ptr -3cH[ebp]
                inc     dword ptr -3cH[ebp]
                jmp     short L1
L3:             imul    eax,dword ptr -3cH[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +4H[eax]
                fcomp   dword ptr L227
                fstsw   ax
                sahf    
                jae     short L4
                imul    eax,dword ptr -3cH[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                mov     dword ptr +4H[eax],0bf000000H
L4:             imul    eax,dword ptr -3cH[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +4H[eax]
                fild    dword ptr _DIBWidth
                fadd    qword ptr L228
                fcompp  st(1)
                fstsw   ax
                sahf    
                jae     short L5
                fild    dword ptr _DIBWidth
                fadd    qword ptr L229
                imul    eax,dword ptr -3cH[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fstp    dword ptr +4H[eax]
L5:             imul    eax,dword ptr -3cH[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +8H[eax]
                fcomp   dword ptr L230
                fstsw   ax
                sahf    
                jae     short L6
                imul    eax,dword ptr -3cH[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                mov     dword ptr +8H[eax],0bf000000H
L6:             imul    eax,dword ptr -3cH[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +8H[eax]
                fild    dword ptr _DIBHeight
                fadd    qword ptr L231
                fcompp  st(1)
                fstsw   ax
                sahf    
                jae     short L7
                fild    dword ptr _DIBHeight
                fadd    qword ptr L232
                imul    eax,dword ptr -3cH[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fstp    dword ptr +8H[eax]
L7:             jmp     near ptr L2
L8:             mov     dword ptr -3cH[ebp],00000000H
L9:             mov     eax,dword ptr -3cH[ebp]
                cmp     eax,dword ptr -34H[ebp]
                jl      short L11
                jmp     near ptr L27
L10:            mov     eax,dword ptr -3cH[ebp]
                inc     dword ptr -3cH[ebp]
                jmp     short L9
L11:            mov     eax,dword ptr -3cH[ebp]
                inc     eax
                mov     dword ptr -38H[ebp],eax
                mov     eax,dword ptr -38H[ebp]
                cmp     eax,dword ptr -34H[ebp]
                jl      short L12
                mov     dword ptr -38H[ebp],00000000H
L12:            imul    edx,dword ptr -3cH[ebp],0cH
                add     edx,dword ptr -44H[ebp]
                imul    eax,dword ptr -38H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +8H[edx]
                fcomp   dword ptr +8H[eax]
                fstsw   ax
                sahf    
                jae     short L13
                mov     eax,dword ptr -3cH[ebp]
                mov     dword ptr -8H[ebp],eax
                mov     eax,dword ptr -38H[ebp]
                mov     dword ptr -4H[ebp],eax
                jmp     short L14
L13:            mov     eax,dword ptr -38H[ebp]
                mov     dword ptr -8H[ebp],eax
                mov     eax,dword ptr -3cH[ebp]
                mov     dword ptr -4H[ebp],eax
L14:            imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +8H[eax]
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr ceil_
                call    near ptr __CHP
                fistp   dword ptr -30H[ebp]
                imul    eax,dword ptr -4H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +8H[eax]
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr ceil_
                call    near ptr __CHP
                fistp   dword ptr -2cH[ebp]
                imul    eax,dword ptr -4H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                imul    edx,dword ptr -8H[ebp],0cH
                add     edx,dword ptr -44H[ebp]
                fld     dword ptr +8H[eax]
                fsub    dword ptr +8H[edx]
                fstp    dword ptr -14H[ebp]
                imul    eax,dword ptr -4H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                imul    edx,dword ptr -8H[ebp],0cH
                add     edx,dword ptr -44H[ebp]
                fld     dword ptr +4H[eax]
                fsub    dword ptr +4H[edx]
                fstp    dword ptr -10H[ebp]
                imul    eax,dword ptr -8H[ebp],0cH
                mov     edx,dword ptr -44H[ebp]
                add     edx,eax
                fild    dword ptr -30H[ebp]
                fstp    dword ptr -68H[ebp]
                mov     dword ptr -0cH[ebp],00000000H
                mov     eax,dword ptr -2cH[ebp]
                cmp     eax,dword ptr -30H[ebp]
                je      near ptr L10
                imul    edx,dword ptr -3cH[ebp],0cH
                add     edx,dword ptr -44H[ebp]
                imul    eax,dword ptr -38H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +8H[edx]
                fcomp   dword ptr +8H[eax]
                fstsw   ax
                sahf    
                jbe     near ptr L15
                mov     eax,dword ptr _pavailedge
                mov     dword ptr +8H[eax],00000001H
                imul    edx,dword ptr -4H[ebp],0cH
                add     edx,dword ptr -44H[ebp]
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +4H[edx]
                fsub    dword ptr +4H[eax]
                fstp    qword ptr -64H[ebp]
                imul    eax,dword ptr -4H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                imul    edx,dword ptr -8H[ebp],0cH
                add     edx,dword ptr -44H[ebp]
                fld     dword ptr +8H[eax]
                fsub    dword ptr +8H[edx]
                fstp    qword ptr -5cH[ebp]
                fld     dword ptr -10H[ebp]
                fdiv    dword ptr -14H[ebp]
                fstp    qword ptr -4cH[ebp]
                fld     qword ptr -4cH[ebp]
                fmul    qword ptr L233
                call    near ptr __CHP
                fistp   dword ptr -68H[ebp]
                mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr -68H[ebp]
                mov     dword ptr +4H[edx],eax
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fild    dword ptr -30H[ebp]
                fsub    dword ptr +8H[eax]
                fmul    qword ptr -4cH[ebp]
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +4H[eax]
                faddp   st(1),st
                fmul    qword ptr L233
                call    near ptr __CHP
                fistp   dword ptr -68H[ebp]
                mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr -68H[ebp]
                mov     dword ptr [edx],eax
                mov     eax,dword ptr -8H[ebp]
                mov     dword ptr -24H[ebp],eax
                mov     eax,dword ptr -4H[ebp]
                mov     dword ptr -20H[ebp],eax
                jmp     near ptr L16
L15:            mov     eax,dword ptr _pavailedge
                mov     dword ptr +8H[eax],00000000H
                imul    edx,dword ptr -4H[ebp],0cH
                add     edx,dword ptr -44H[ebp]
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +4H[edx]
                fsub    dword ptr +4H[eax]
                fstp    qword ptr -64H[ebp]
                imul    eax,dword ptr -4H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                imul    edx,dword ptr -8H[ebp],0cH
                add     edx,dword ptr -44H[ebp]
                fld     dword ptr +8H[eax]
                fsub    dword ptr +8H[edx]
                fstp    qword ptr -5cH[ebp]
                fld     dword ptr -10H[ebp]
                fdiv    dword ptr -14H[ebp]
                fstp    qword ptr -4cH[ebp]
                fld     qword ptr -4cH[ebp]
                fmul    qword ptr L234
                call    near ptr __CHP
                fistp   dword ptr -68H[ebp]
                mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr -68H[ebp]
                mov     dword ptr +4H[edx],eax
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fild    dword ptr -30H[ebp]
                fsub    dword ptr +8H[eax]
                fmul    qword ptr -4cH[ebp]
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +4H[eax]
                faddp   st(1),st
                fmul    qword ptr L234
                call    near ptr __CHP
                fistp   dword ptr -68H[ebp]
                mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr -68H[ebp]
                mov     dword ptr [edx],eax
                mov     eax,dword ptr -8H[ebp]
                mov     dword ptr -24H[ebp],eax
                mov     eax,dword ptr -4H[ebp]
                mov     dword ptr -20H[ebp],eax
L16:            imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                test    dword ptr +0cH[eax],7fffffffH
                jne     short L17
                mov     dword ptr -1cH[ebp],497423f0H
                jmp     short L18
L17:            imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +0cH[eax]
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr -1cH[ebp]
L18:            imul    eax,dword ptr -4H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                test    dword ptr +0cH[eax],7fffffffH
                jne     short L19
                mov     dword ptr -18H[ebp],497423f0H
                jmp     short L20
L19:            imul    eax,dword ptr -4H[ebp],0cH
                add     eax,dword ptr -44H[ebp]
                fld     dword ptr +0cH[eax]
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr -18H[ebp]
L20:            mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr -1cH[ebp]
                mov     dword ptr +0cH[edx],eax
                test    dword ptr -58H[ebp],7fffffffH
                jne     short L21
                cmp     dword ptr -5cH[ebp],00000000H
                je      short L22
L21:            fld     dword ptr -14H[ebp]
                fstp    qword ptr -5cH[ebp]
                fld     dword ptr -18H[ebp]
                fsub    dword ptr -1cH[ebp]
                fdiv    qword ptr -5cH[ebp]
                mov     eax,dword ptr _pavailedge
                fstp    dword ptr +10H[eax]
                jmp     short L23
L22:            mov     eax,dword ptr _pavailedge
                mov     dword ptr +10H[eax],00000000H
L23:            imul    eax,dword ptr -30H[ebp],24H
                mov     edx,offset DGROUP:_newedges
                add     edx,eax
                mov     dword ptr -28H[ebp],edx
L24:            mov     eax,dword ptr -28H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr [eax]
                cmp     eax,dword ptr [edx]
                jge     short L25
                mov     eax,dword ptr -28H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr -28H[ebp],eax
                jmp     short L24
L25:            mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr -28H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr +18H[edx],eax
                mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr -28H[ebp]
                mov     dword ptr +18H[eax],edx
                mov     eax,dword ptr -2cH[ebp]
                shl     eax,02H
                mov     edx,dword ptr _pavailedge
                mov     eax,dword ptr _removeedges-4H[eax]
                mov     dword ptr +20H[edx],eax
                mov     eax,dword ptr -2cH[ebp]
                shl     eax,02H
                mov     edx,dword ptr _pavailedge
                mov     dword ptr _removeedges-4H[eax],edx
                mov     eax,dword ptr _pavailedge
                mov     edx,dword ptr _pavailsurf
                mov     dword ptr +14H[eax],edx
                mov     eax,offset DGROUP:_edges+1a5e0H
                cmp     eax,dword ptr _pavailedge
                jbe     short L26
                add     dword ptr _pavailedge,00000024H
L26:            jmp     near ptr L10
L27:            mov     eax,dword ptr _pavailsurf
                mov     dword ptr +38H[eax],00000000H
                mov     eax,dword ptr _pavailsurf
                mov     esi,dword ptr _currentcolor
                mov     dword ptr +8H[eax],esi
                mov     eax,dword ptr _pavailsurf
                mov     esi,dword ptr _currentbspdepth
                mov     dword ptr +30H[eax],esi
                mov     esi,dword ptr _pavailsurf
                lea     edi,+0cH[esi]
                mov     esi,offset DGROUP:_A
                movsd   
                movsd   
                movsd   
                mov     esi,dword ptr _pavailsurf
                lea     edi,+18H[esi]
                mov     esi,offset DGROUP:_B
                movsd   
                movsd   
                movsd   
                mov     esi,dword ptr _pavailsurf
                lea     edi,+24H[esi]
                mov     esi,offset DGROUP:_C
                movsd   
                movsd   
                movsd   
                mov     eax,dword ptr -40H[ebp]
                fld     dword ptr [eax]
                fld1    
                fdivrp  st(1),st
                fstp    qword ptr -54H[ebp]
                mov     eax,offset DGROUP:_surfs+34bc0H
                cmp     eax,dword ptr _pavailsurf
                jbe     short L28
                add     dword ptr _pavailsurf,00000048H
L28:            mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     
VBE_DrawSpans_: push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000028H
                fstcw   dword ptr _OldFPUCW
                mov     ax,word ptr _OldFPUCW
                and     eax,00000cffH
                mov     word ptr _FPUCW,ax
                fldcw   dword ptr _FPUCW
                mov     eax,offset DGROUP:_coockieModeInfo
                call    near ptr coockie_getLinearSelector_
                and     eax,0000ffffH
                mov     dword ptr _coockieGS,eax
                mov     eax,dword ptr _coockieGS
                mov     gs,ax
                mov     dword ptr -24H[ebp],offset DGROUP:_spans
L29:            mov     eax,dword ptr -24H[ebp]
                cmp     dword ptr [eax],0ffffffffH
                jne     short L31
                jmp     near ptr L49
L30:            mov     eax,dword ptr -24H[ebp]
                add     dword ptr -24H[ebp],00000038H
                jmp     short L29
L31:            mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +4H[eax]
                add     eax,dword ptr _WindowOffsetY
                mov     edx,dword ptr _DIBPitch
                imul    edx,eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                add     eax,dword ptr _WindowOffsetX
                add     eax,edx
                mov     dword ptr _screenbuffer,eax
                mov     eax,dword ptr -24H[ebp]
                cmp     dword ptr +34H[eax],0ffffffffH
                je      near ptr L46
                mov     eax,dword ptr _texturestart
                mov     dword ptr _pcxtexture,eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +34H[eax]
                and     eax,0000007fH
                shl     eax,10H
                add     dword ptr _pcxtexture,eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                mov     dword ptr -8H[ebp],eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +4H[eax]
                mov     dword ptr -4H[ebp],eax
                fild    dword ptr _RUN_LENGTH
                mov     eax,dword ptr -24H[ebp]
                fmul    dword ptr +10H[eax]
                fstp    dword ptr -1cH[ebp]
                fild    dword ptr _RUN_LENGTH
                mov     eax,dword ptr -24H[ebp]
                fmul    dword ptr +1cH[eax]
                fstp    dword ptr -18H[ebp]
                fild    dword ptr _RUN_LENGTH
                mov     eax,dword ptr -24H[ebp]
                fmul    dword ptr +28H[eax]
                fstp    dword ptr -14H[ebp]
                fild    dword ptr -8H[ebp]
                fsub    dword ptr _xcenter
                fstp    dword ptr -10H[ebp]
                fild    dword ptr -4H[ebp]
                fsub    dword ptr _ycenter
                fstp    dword ptr -0cH[ebp]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -10H[ebp]
                fmul    dword ptr +10H[eax]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -0cH[ebp]
                fmul    dword ptr +14H[eax]
                faddp   st(1),st
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +18H[eax]
                faddp   st(1),st
                fstp    dword ptr _aa
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -10H[ebp]
                fmul    dword ptr +1cH[eax]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -0cH[ebp]
                fmul    dword ptr +20H[eax]
                faddp   st(1),st
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +24H[eax]
                faddp   st(1),st
                fstp    dword ptr _bb
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -10H[ebp]
                fmul    dword ptr +28H[eax]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -0cH[ebp]
                fmul    dword ptr +2cH[eax]
                faddp   st(1),st
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +30H[eax]
                faddp   st(1),st
                fstp    dword ptr _cc
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +8H[eax]
                fcomp   dword ptr _maxscale
                fstsw   ax
                sahf    
                jae     short L32
                mov     dword ptr _mask2,00007f7fH
                mov     dword ptr _mipmask,00000000H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41700000H
                jmp     near ptr L36
L32:            fld     dword ptr _maxscale
                fmul    dword ptr L235
                mov     eax,dword ptr -24H[ebp]
                fcomp   dword ptr +8H[eax]
                fstsw   ax
                sahf    
                jbe     short L33
                mov     dword ptr _mask2,00003f3fH
                mov     dword ptr _mipmask,00000080H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41600000H
                jmp     near ptr L36
L33:            fld     dword ptr _maxscale
                fmul    dword ptr L236
                mov     eax,dword ptr -24H[ebp]
                fcomp   dword ptr +8H[eax]
                fstsw   ax
                sahf    
                jbe     short L34
                mov     dword ptr _mask2,00001f1fH
                mov     dword ptr _mipmask,000000c0H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41500000H
                jmp     short L36
L34:            fld     dword ptr _maxscale
                fmul    dword ptr L237
                mov     eax,dword ptr -24H[ebp]
                fcomp   dword ptr +8H[eax]
                fstsw   ax
                sahf    
                jbe     short L35
                mov     dword ptr _mask2,00000f0fH
                mov     dword ptr _mipmask,000000e0H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41400000H
                jmp     short L36
L35:            mov     dword ptr _mask2,00000707H
                mov     dword ptr _mipmask,000000f0H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41300000H
L36:            mov     eax,dword ptr -24H[ebp]
                cmp     dword ptr +34H[eax],00000000H
                je      short L37
                cmp     dword ptr _mip,3f800000H
                jne     short L38
L37:            mov     dword ptr _mask2,00007f7fH
                mov     dword ptr _mipmask,00000000H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41700000H
L38:            fld1    
                fdiv    dword ptr _cc
                fstp    dword ptr _cinv
                fld     qword ptr _sixtyfive
                fmul    dword ptr _cinv
                fld     st(0)
                fmul    dword ptr _aa
                fistp   dword ptr _u0
                fmul    dword ptr _bb
                fistp   dword ptr _v0
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +0cH[eax]
                mov     dword ptr -20H[ebp],eax
                fld     dword ptr _aa
                fadd    dword ptr -1cH[ebp]
                fstp    dword ptr _aa
                fld     dword ptr _bb
                fadd    dword ptr -18H[ebp]
                fstp    dword ptr _bb
                fld     dword ptr _cc
                fadd    dword ptr -14H[ebp]
                fstp    dword ptr _cc
                fld1    
                fdiv    dword ptr _cc
                fstp    dword ptr _cinv
                fld     qword ptr _sixtyfive
                fmul    dword ptr _cinv
                fld     st(0)
                fmul    dword ptr _aa
                fistp   dword ptr _u1
                fmul    dword ptr _bb
                fistp   dword ptr _v1
                mov     eax,dword ptr _RUN_LENGTH
                mov     dword ptr _run,eax
L39:            mov     eax,dword ptr -20H[ebp]
                cmp     eax,dword ptr _RUN_LENGTH
                jl      near ptr L41
                mov     eax,dword ptr _u1
                sub     eax,dword ptr _u0
                mov     ecx,dword ptr _RUN_LENGTHEXP
                sar     eax,cl
                mov     dword ptr _du,eax
                mov     eax,dword ptr _v1
                sub     eax,dword ptr _v0
                mov     ecx,dword ptr _RUN_LENGTHEXP
                sar     eax,cl
                mov     dword ptr _dv,eax
                fld     dword ptr _aa
                fadd    dword ptr -1cH[ebp]
                fstp    dword ptr _aa
                fld     dword ptr _bb
                fadd    dword ptr -18H[ebp]
                fstp    dword ptr _bb
                fld     dword ptr _cc
                fadd    dword ptr -14H[ebp]
                fstp    dword ptr _cc
                mov     eax,dword ptr _u0
                sar     eax,10H
                mov     dword ptr _u,eax
                mov     eax,dword ptr _v0
                sar     eax,10H
                mov     dword ptr _v,eax
                fld1    
                fdiv    dword ptr _cc
                mov     eax,dword ptr _du
                sar     eax,10H
                mov     dword ptr _du_hi,eax
                mov     eax,dword ptr _du
                and     eax,0000ffffH
                mov     dword ptr _du_lo,eax
                mov     eax,dword ptr _dv
                sar     eax,10H
                mov     dword ptr _dv_hi,eax
                mov     eax,dword ptr _dv
                and     eax,0000ffffH
                mov     dword ptr _dv_lo,eax
                mov     eax,dword ptr _u0
                and     eax,0000ffffH
                mov     dword ptr _fu_lo,eax
                mov     eax,dword ptr _v0
                and     eax,0000ffffH
                mov     dword ptr _fv_lo,eax
                mov     eax,dword ptr _pcxtexture
                add     al,byte ptr _u
                add     ah,byte ptr _v
                mov     ebx,eax
                mov     edi,dword ptr _screenbuffer
                and     bx,word ptr _mask2
                mov     dx,word ptr _fu_lo
                shl     edx,10H
                mov     dh,byte ptr _dv_hi
                mov     dl,byte ptr _du_hi
                mov     ax,word ptr _fv_lo
                shl     eax,10H
                mov     si,word ptr _du_lo
                shl     esi,10H
                mov     cx,word ptr _dv_lo
                shl     ecx,10H
                mov     cx,word ptr _run
                push    ebp
                xor     ebp,ebp
                mov     bp,cx
                xor     cx,cx
                add     edi,ebp
                neg     ebp
L40:            and     bx,word ptr _mask2
                or      bx,word ptr _mipmask
                mov     al,byte ptr [ebx]
                add     edx,esi
                adc     bl,dl
                add     eax,ecx
                adc     bh,dh
                mov     byte ptr gs:[edi+ebp],al
                inc     ebp
                jne     short L40
                pop     ebp
                mov     dword ptr _screenbuffer,edi
                fstp    dword ptr _cinv
                mov     eax,dword ptr _run
                sub     dword ptr -20H[ebp],eax
                mov     eax,dword ptr _u1
                mov     dword ptr _u0,eax
                mov     eax,dword ptr _v1
                mov     dword ptr _v0,eax
                fld     qword ptr _sixtyfive
                fmul    dword ptr _cinv
                fld     st(0)
                fmul    dword ptr _aa
                fistp   dword ptr _u1
                fmul    dword ptr _bb
                fistp   dword ptr _v1
                jmp     near ptr L39
L41:            cmp     dword ptr -20H[ebp],00000000H
                je      near ptr L45
                mov     eax,dword ptr -20H[ebp]
                cmp     eax,dword ptr _RUN_LENGTH
                jle     short L42
                mov     eax,dword ptr _RUN_LENGTH
                mov     dword ptr -28H[ebp],eax
                jmp     short L43
L42:            mov     eax,dword ptr -20H[ebp]
                mov     dword ptr -28H[ebp],eax
L43:            mov     eax,dword ptr -28H[ebp]
                mov     dword ptr _run,eax
                mov     eax,dword ptr _u1
                sub     eax,dword ptr _u0
                mov     ecx,dword ptr _RUN_LENGTHEXP
                sar     eax,cl
                mov     dword ptr _du,eax
                mov     eax,dword ptr _v1
                sub     eax,dword ptr _v0
                mov     ecx,dword ptr _RUN_LENGTHEXP
                sar     eax,cl
                mov     dword ptr _dv,eax
                mov     eax,dword ptr _u0
                sar     eax,10H
                mov     dword ptr _u,eax
                mov     eax,dword ptr _v0
                sar     eax,10H
                mov     dword ptr _v,eax
                mov     eax,dword ptr _du
                sar     eax,10H
                mov     dword ptr _du_hi,eax
                mov     eax,dword ptr _du
                and     eax,0000ffffH
                mov     dword ptr _du_lo,eax
                mov     eax,dword ptr _dv
                sar     eax,10H
                mov     dword ptr _dv_hi,eax
                mov     eax,dword ptr _dv
                and     eax,0000ffffH
                mov     dword ptr _dv_lo,eax
                mov     eax,dword ptr _u0
                and     eax,0000ffffH
                mov     dword ptr _fu_lo,eax
                mov     eax,dword ptr _v0
                and     eax,0000ffffH
                mov     dword ptr _fv_lo,eax
                mov     eax,dword ptr _pcxtexture
                add     al,byte ptr _u
                add     ah,byte ptr _v
                mov     ebx,eax
                mov     edi,dword ptr _screenbuffer
                and     bx,word ptr _mask2
                mov     dx,word ptr _fu_lo
                shl     edx,10H
                mov     dh,byte ptr _dv_hi
                mov     dl,byte ptr _du_hi
                mov     ax,word ptr _fv_lo
                shl     eax,10H
                mov     si,word ptr _du_lo
                shl     esi,10H
                mov     cx,word ptr _dv_lo
                shl     ecx,10H
                mov     cx,word ptr _run
                push    ebp
                xor     ebp,ebp
                mov     bp,cx
                xor     cx,cx
                add     edi,ebp
                neg     ebp
L44:            and     bx,word ptr _mask2
                or      bx,word ptr _mipmask
                mov     al,byte ptr [ebx]
                add     edx,esi
                adc     bl,dl
                add     eax,ecx
                adc     bh,dh
                mov     byte ptr gs:[edi+ebp],al
                inc     ebp
                jne     short L44
                pop     ebp
                mov     dword ptr _screenbuffer,edi
L45:            jmp     short L48
L46:            mov     dword ptr _VBE_Color,00000000H
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +0cH[eax]
                mov     dword ptr _VBE_Count,eax
                mov     ecx,dword ptr _VBE_Count
                mov     eax,dword ptr _VBE_Color
                mov     edi,dword ptr _screenbuffer
L47:            mov     byte ptr gs:[ecx+edi],al
                dec     ecx
                jne     short L47
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +0cH[eax]
                add     dword ptr _screenbuffer,eax
L48:            jmp     near ptr L30
L49:            fldcw   dword ptr _OldFPUCW
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
VGA_DrawSpans_: push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000028H
                fstcw   dword ptr _OldFPUCW
                mov     ax,word ptr _OldFPUCW
                and     eax,00000cffH
                mov     word ptr _FPUCW,ax
                fldcw   dword ptr _FPUCW
                mov     eax,dword ptr _VideoOffset
                mov     dword ptr _screenbuffer,eax
                mov     dword ptr -24H[ebp],offset DGROUP:_spans
L50:            mov     eax,dword ptr -24H[ebp]
                cmp     dword ptr [eax],0ffffffffH
                jne     short L52
                jmp     near ptr L69
L51:            mov     eax,dword ptr -24H[ebp]
                add     dword ptr -24H[ebp],00000038H
                jmp     short L50
L52:            mov     eax,dword ptr _VideoOffset
                mov     dword ptr _screenbuffer,eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +4H[eax]
                add     eax,dword ptr _WindowOffsetY
                mov     edx,dword ptr _DIBPitch
                imul    edx,eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                add     eax,dword ptr _WindowOffsetX
                add     eax,edx
                add     dword ptr _screenbuffer,eax
                mov     eax,dword ptr -24H[ebp]
                cmp     dword ptr +34H[eax],0ffffffffH
                je      near ptr L67
                mov     eax,dword ptr _texturestart
                mov     dword ptr _pcxtexture,eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +34H[eax]
                and     eax,0000007fH
                shl     eax,10H
                add     dword ptr _pcxtexture,eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                mov     dword ptr -8H[ebp],eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +4H[eax]
                mov     dword ptr -4H[ebp],eax
                fild    dword ptr _RUN_LENGTH
                mov     eax,dword ptr -24H[ebp]
                fmul    dword ptr +10H[eax]
                fstp    dword ptr -1cH[ebp]
                fild    dword ptr _RUN_LENGTH
                mov     eax,dword ptr -24H[ebp]
                fmul    dword ptr +1cH[eax]
                fstp    dword ptr -18H[ebp]
                fild    dword ptr _RUN_LENGTH
                mov     eax,dword ptr -24H[ebp]
                fmul    dword ptr +28H[eax]
                fstp    dword ptr -14H[ebp]
                fild    dword ptr -8H[ebp]
                fsub    dword ptr _xcenter
                fstp    dword ptr -10H[ebp]
                fild    dword ptr -4H[ebp]
                fsub    dword ptr _ycenter
                fstp    dword ptr -0cH[ebp]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -10H[ebp]
                fmul    dword ptr +10H[eax]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -0cH[ebp]
                fmul    dword ptr +14H[eax]
                faddp   st(1),st
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +18H[eax]
                faddp   st(1),st
                fstp    dword ptr _aa
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -10H[ebp]
                fmul    dword ptr +1cH[eax]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -0cH[ebp]
                fmul    dword ptr +20H[eax]
                faddp   st(1),st
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +24H[eax]
                faddp   st(1),st
                fstp    dword ptr _bb
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -10H[ebp]
                fmul    dword ptr +28H[eax]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr -0cH[ebp]
                fmul    dword ptr +2cH[eax]
                faddp   st(1),st
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +30H[eax]
                faddp   st(1),st
                fstp    dword ptr _cc
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +8H[eax]
                fcomp   dword ptr _maxscale
                fstsw   ax
                sahf    
                jae     short L53
                mov     dword ptr _mask2,00007f7fH
                mov     dword ptr _mipmask,00000000H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41700000H
                jmp     near ptr L57
L53:            fld     dword ptr _maxscale
                fmul    dword ptr L238
                mov     eax,dword ptr -24H[ebp]
                fcomp   dword ptr +8H[eax]
                fstsw   ax
                sahf    
                jbe     short L54
                mov     dword ptr _mask2,00003f3fH
                mov     dword ptr _mipmask,00000080H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41600000H
                jmp     near ptr L57
L54:            fld     dword ptr _maxscale
                fmul    dword ptr L239
                mov     eax,dword ptr -24H[ebp]
                fcomp   dword ptr +8H[eax]
                fstsw   ax
                sahf    
                jbe     short L55
                mov     dword ptr _mask2,00001f1fH
                mov     dword ptr _mipmask,000000c0H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41500000H
                jmp     short L57
L55:            fld     dword ptr _maxscale
                fmul    dword ptr L240
                mov     eax,dword ptr -24H[ebp]
                fcomp   dword ptr +8H[eax]
                fstsw   ax
                sahf    
                jbe     short L56
                mov     dword ptr _mask2,00000f0fH
                mov     dword ptr _mipmask,000000e0H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41400000H
                jmp     short L57
L56:            mov     dword ptr _mask2,00000707H
                mov     dword ptr _mipmask,000000f0H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41300000H
L57:            mov     eax,dword ptr -24H[ebp]
                cmp     dword ptr +34H[eax],00000000H
                je      short L58
                cmp     dword ptr _mip,3f800000H
                jne     short L59
L58:            mov     dword ptr _mask2,00007f7fH
                mov     dword ptr _mipmask,00000000H
                mov     dword ptr _sixtyfive,00000000H
                mov     dword ptr _sixtyfive+4H,41700000H
L59:            fld1    
                fdiv    dword ptr _cc
                fstp    dword ptr _cinv
                fld     qword ptr _sixtyfive
                fmul    dword ptr _cinv
                fld     st(0)
                fmul    dword ptr _aa
                fistp   dword ptr _u0
                fmul    dword ptr _bb
                fistp   dword ptr _v0
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +0cH[eax]
                mov     dword ptr -20H[ebp],eax
                fld     dword ptr _aa
                fadd    dword ptr -1cH[ebp]
                fstp    dword ptr _aa
                fld     dword ptr _bb
                fadd    dword ptr -18H[ebp]
                fstp    dword ptr _bb
                fld     dword ptr _cc
                fadd    dword ptr -14H[ebp]
                fstp    dword ptr _cc
                fld1    
                fdiv    dword ptr _cc
                fstp    dword ptr _cinv
                fld     qword ptr _sixtyfive
                fmul    dword ptr _cinv
                fld     st(0)
                fmul    dword ptr _aa
                fistp   dword ptr _u1
                fmul    dword ptr _bb
                fistp   dword ptr _v1
                mov     eax,dword ptr _RUN_LENGTH
                mov     dword ptr _run,eax
L60:            mov     eax,dword ptr -20H[ebp]
                cmp     eax,dword ptr _RUN_LENGTH
                jl      near ptr L62
                mov     eax,dword ptr _u1
                sub     eax,dword ptr _u0
                mov     ecx,dword ptr _RUN_LENGTHEXP
                sar     eax,cl
                mov     dword ptr _du,eax
                mov     eax,dword ptr _v1
                sub     eax,dword ptr _v0
                mov     ecx,dword ptr _RUN_LENGTHEXP
                sar     eax,cl
                mov     dword ptr _dv,eax
                fld     dword ptr _aa
                fadd    dword ptr -1cH[ebp]
                fstp    dword ptr _aa
                fld     dword ptr _bb
                fadd    dword ptr -18H[ebp]
                fstp    dword ptr _bb
                fld     dword ptr _cc
                fadd    dword ptr -14H[ebp]
                fstp    dword ptr _cc
                mov     eax,dword ptr _u0
                sar     eax,10H
                mov     dword ptr _u,eax
                mov     eax,dword ptr _v0
                sar     eax,10H
                mov     dword ptr _v,eax
                fld1    
                fdiv    dword ptr _cc
                mov     eax,dword ptr _du
                sar     eax,10H
                mov     dword ptr _du_hi,eax
                mov     eax,dword ptr _du
                and     eax,0000ffffH
                mov     dword ptr _du_lo,eax
                mov     eax,dword ptr _dv
                sar     eax,10H
                mov     dword ptr _dv_hi,eax
                mov     eax,dword ptr _dv
                and     eax,0000ffffH
                mov     dword ptr _dv_lo,eax
                mov     eax,dword ptr _u0
                and     eax,0000ffffH
                mov     dword ptr _fu_lo,eax
                mov     eax,dword ptr _v0
                and     eax,0000ffffH
                mov     dword ptr _fv_lo,eax
                mov     eax,dword ptr _pcxtexture
                add     al,byte ptr _u
                add     ah,byte ptr _v
                mov     ebx,eax
                mov     edi,dword ptr _screenbuffer
                and     bx,word ptr _mask2
                mov     dx,word ptr _fu_lo
                shl     edx,10H
                mov     dh,byte ptr _dv_hi
                mov     dl,byte ptr _du_hi
                mov     ax,word ptr _fv_lo
                shl     eax,10H
                mov     si,word ptr _du_lo
                shl     esi,10H
                mov     cx,word ptr _dv_lo
                shl     ecx,10H
                mov     cx,word ptr _run
                push    ebp
                xor     ebp,ebp
                mov     bp,cx
                xor     cx,cx
                add     edi,ebp
                neg     ebp
L61:            and     bx,word ptr _mask2
                or      bx,word ptr _mipmask
                mov     al,byte ptr [ebx]
                add     edx,esi
                adc     bl,dl
                add     eax,ecx
                adc     bh,dh
                mov     byte ptr [edi+ebp],al
                inc     ebp
                jne     short L61
                pop     ebp
                mov     dword ptr _screenbuffer,edi
                fstp    dword ptr _cinv
                mov     eax,dword ptr _run
                sub     dword ptr -20H[ebp],eax
                mov     eax,dword ptr _u1
                mov     dword ptr _u0,eax
                mov     eax,dword ptr _v1
                mov     dword ptr _v0,eax
                fld     qword ptr _sixtyfive
                fmul    dword ptr _cinv
                fld     st(0)
                fmul    dword ptr _aa
                fistp   dword ptr _u1
                fmul    dword ptr _bb
                fistp   dword ptr _v1
                jmp     near ptr L60
L62:            cmp     dword ptr -20H[ebp],00000000H
                je      near ptr L66
                mov     eax,dword ptr -20H[ebp]
                cmp     eax,dword ptr _RUN_LENGTH
                jle     short L63
                mov     eax,dword ptr _RUN_LENGTH
                mov     dword ptr -28H[ebp],eax
                jmp     short L64
L63:            mov     eax,dword ptr -20H[ebp]
                mov     dword ptr -28H[ebp],eax
L64:            mov     eax,dword ptr -28H[ebp]
                mov     dword ptr _run,eax
                mov     eax,dword ptr _u1
                sub     eax,dword ptr _u0
                mov     ecx,dword ptr _RUN_LENGTHEXP
                sar     eax,cl
                mov     dword ptr _du,eax
                mov     eax,dword ptr _v1
                sub     eax,dword ptr _v0
                mov     ecx,dword ptr _RUN_LENGTHEXP
                sar     eax,cl
                mov     dword ptr _dv,eax
                mov     eax,dword ptr _u0
                sar     eax,10H
                mov     dword ptr _u,eax
                mov     eax,dword ptr _v0
                sar     eax,10H
                mov     dword ptr _v,eax
                mov     eax,dword ptr _du
                sar     eax,10H
                mov     dword ptr _du_hi,eax
                mov     eax,dword ptr _du
                and     eax,0000ffffH
                mov     dword ptr _du_lo,eax
                mov     eax,dword ptr _dv
                sar     eax,10H
                mov     dword ptr _dv_hi,eax
                mov     eax,dword ptr _dv
                and     eax,0000ffffH
                mov     dword ptr _dv_lo,eax
                mov     eax,dword ptr _u0
                and     eax,0000ffffH
                mov     dword ptr _fu_lo,eax
                mov     eax,dword ptr _v0
                and     eax,0000ffffH
                mov     dword ptr _fv_lo,eax
                mov     eax,dword ptr _pcxtexture
                add     al,byte ptr _u
                add     ah,byte ptr _v
                mov     ebx,eax
                mov     edi,dword ptr _screenbuffer
                and     bx,word ptr _mask2
                mov     dx,word ptr _fu_lo
                shl     edx,10H
                mov     dh,byte ptr _dv_hi
                mov     dl,byte ptr _du_hi
                mov     ax,word ptr _fv_lo
                shl     eax,10H
                mov     si,word ptr _du_lo
                shl     esi,10H
                mov     cx,word ptr _dv_lo
                shl     ecx,10H
                mov     cx,word ptr _run
                push    ebp
                xor     ebp,ebp
                mov     bp,cx
                xor     cx,cx
                add     edi,ebp
                neg     ebp
L65:            and     bx,word ptr _mask2
                or      bx,word ptr _mipmask
                mov     al,byte ptr [ebx]
                add     edx,esi
                adc     bl,dl
                add     eax,ecx
                adc     bh,dh
                mov     byte ptr [edi+ebp],al
                inc     ebp
                jne     short L65
                pop     ebp
                mov     dword ptr _screenbuffer,edi
L66:            jmp     short L68
L67:            mov     eax,dword ptr -24H[ebp]
                mov     ebx,dword ptr +0cH[eax]
                xor     edx,edx
                mov     eax,dword ptr _screenbuffer
                call    near ptr memset_
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +0cH[eax]
                add     dword ptr _screenbuffer,eax
L68:            jmp     near ptr L51
L69:            fldcw   dword ptr _OldFPUCW
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
ScanEdges_:     push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000060H
                mov     dword ptr -10H[ebp],offset DGROUP:_spans
                mov     dword ptr -50H[ebp],0c97423f0H
                mov     dword ptr -4cH[ebp],00000000H
                mov     dword ptr _edgehead+18H,offset DGROUP:_edgetail
                mov     dword ptr _edgehead+1cH,00000000H
                mov     dword ptr _edgehead,0ffff0001H
                mov     dword ptr _edgehead+8H,00000001H
                mov     dword ptr _edgehead+14H,offset DGROUP:_surfstack
                mov     dword ptr _edgetail+18H,00000000H
                mov     dword ptr _edgetail+1cH,offset DGROUP:_edgehead
                mov     eax,dword ptr _DIBWidth
                shl     eax,10H
                mov     dword ptr _edgetail,eax
                mov     dword ptr _edgetail+8H,00000000H
                mov     dword ptr _edgetail+14H,offset DGROUP:_surfstack
                mov     dword ptr _surfstack+4H,offset DGROUP:_surfstack
                mov     eax,dword ptr _surfstack+4H
                mov     dword ptr _surfstack,eax
                mov     dword ptr _surfstack+8H,0ffffffffH
                mov     dword ptr _surfstack+30H,0ffff8001H
                mov     dword ptr _surfstack+40H,0c97423f0H
                mov     dword ptr _surfstack+44H,00000000H
                lea     eax,-5cH[ebp]
                mov     dword ptr _surfstack+3cH,eax
                mov     dword ptr -30H[ebp],00000000H
L70:            mov     eax,dword ptr -30H[ebp]
                cmp     eax,dword ptr _DIBHeight
                jl      short L72
                jmp     near ptr L116
L71:            mov     eax,dword ptr -30H[ebp]
                inc     dword ptr -30H[ebp]
                jmp     short L70
L72:            fild    dword ptr -30H[ebp]
                fstp    dword ptr -14H[ebp]
                imul    eax,dword ptr -30H[ebp],24H
                mov     eax,dword ptr _newedges+18H[eax]
                mov     dword ptr -24H[ebp],eax
                mov     dword ptr -20H[ebp],offset DGROUP:_edgehead
L73:            mov     eax,offset DGROUP:_maxedge
                cmp     eax,dword ptr -24H[ebp]
                je      short L76
L74:            mov     eax,dword ptr -20H[ebp]
                mov     edx,dword ptr +18H[eax]
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                cmp     eax,dword ptr [edx]
                jle     short L75
                mov     eax,dword ptr -20H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr -20H[ebp],eax
                jmp     short L74
L75:            mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr -1cH[ebp],eax
                mov     eax,dword ptr -20H[ebp]
                mov     edx,dword ptr +18H[eax]
                mov     eax,dword ptr -24H[ebp]
                mov     dword ptr +18H[eax],edx
                mov     eax,dword ptr -20H[ebp]
                mov     edx,dword ptr -24H[ebp]
                mov     dword ptr +1cH[edx],eax
                mov     eax,dword ptr -20H[ebp]
                mov     edx,dword ptr +18H[eax]
                mov     eax,dword ptr -24H[ebp]
                mov     dword ptr +1cH[edx],eax
                mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr -20H[ebp]
                mov     dword ptr +18H[edx],eax
                mov     eax,dword ptr -24H[ebp]
                mov     dword ptr -20H[ebp],eax
                mov     eax,dword ptr -1cH[ebp]
                mov     dword ptr -24H[ebp],eax
                jmp     short L73
L76:            mov     dword ptr _surfstack+38H,00000001H
                mov     dword ptr _surfstack+34H,00000000H
                mov     eax,dword ptr _edgehead+18H
                mov     dword ptr -24H[ebp],eax
L77:            cmp     dword ptr -24H[ebp],00000000H
                jne     short L79
                jmp     near ptr L107
L78:            mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr -24H[ebp],eax
                jmp     short L77
L79:            mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +14H[eax]
                mov     dword ptr -0cH[ebp],eax
                mov     eax,dword ptr -24H[ebp]
                cmp     dword ptr +8H[eax],00000000H
                je      near ptr L102
                mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr -0cH[ebp]
                mov     dword ptr +3cH[edx],eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr -18H[ebp],eax
L80:            cmp     dword ptr -18H[ebp],00000000H
                je      short L81
                mov     eax,offset DGROUP:_maxedge
                cmp     eax,dword ptr -18H[ebp]
                jne     short L82
L81:            jmp     short L83
L82:            mov     eax,dword ptr -18H[ebp]
                mov     eax,dword ptr +14H[eax]
                cmp     eax,dword ptr -0cH[ebp]
                je      short L83
                mov     eax,dword ptr -18H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr -18H[ebp],eax
                jmp     short L80
L83:            cmp     dword ptr -18H[ebp],00000000H
                jne     short L84
                mov     dword ptr -4H[ebp],00000000H
                jmp     short L85
L84:            mov     eax,dword ptr -18H[ebp]
                fild    dword ptr [eax]
                fmul    qword ptr L241
                mov     eax,dword ptr -24H[ebp]
                fild    dword ptr [eax]
                fmul    qword ptr L241
                fsubp   st(1),st
                fstp    dword ptr -4H[ebp]
L85:            test    dword ptr -4H[ebp],7fffffffH
                je      short L86
                mov     eax,offset DGROUP:_maxedge
                cmp     eax,dword ptr -18H[ebp]
                jne     short L87
L86:            jmp     short L88
L87:            mov     eax,dword ptr -18H[ebp]
                fld     dword ptr +0cH[eax]
                mov     eax,dword ptr -24H[ebp]
                fsub    dword ptr +0cH[eax]
                mov     eax,dword ptr -0cH[ebp]
                fdiv    dword ptr -4H[ebp]
                fstp    dword ptr +44H[eax]
                jmp     short L89
L88:            mov     eax,dword ptr -0cH[ebp]
                mov     dword ptr +44H[eax],00000000H
L89:            mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                add     eax,0000ffffH
                sar     eax,10H
                mov     dword ptr -60H[ebp],eax
                fild    dword ptr -60H[ebp]
                fstp    dword ptr -34H[ebp]
                mov     eax,dword ptr -0cH[ebp]
                fld     dword ptr -34H[ebp]
                fmul    dword ptr +44H[eax]
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +0cH[eax]
                fsubrp  st(1),st
                mov     eax,dword ptr -0cH[ebp]
                fstp    dword ptr +40H[eax]
                mov     eax,dword ptr -0cH[ebp]
                inc     dword ptr +38H[eax]
                mov     eax,dword ptr -0cH[ebp]
                cmp     dword ptr +38H[eax],00000001H
                jne     near ptr L101
                mov     eax,dword ptr _surfstack
                mov     dword ptr -8H[ebp],eax
                mov     eax,dword ptr -0cH[ebp]
                cmp     dword ptr +30H[eax],0ffffffffH
                je      short L90
                mov     eax,dword ptr -8H[ebp]
                cmp     dword ptr +30H[eax],0ffffffffH
                jne     short L91
L90:            jmp     short L92
L91:            mov     eax,dword ptr -8H[ebp]
                fild    dword ptr +30H[eax]
                fstp    dword ptr -28H[ebp]
                mov     eax,dword ptr -0cH[ebp]
                fild    dword ptr +30H[eax]
                fstp    dword ptr -2cH[ebp]
                jmp     short L93
L92:            mov     eax,dword ptr -8H[ebp]
                fld     dword ptr +44H[eax]
                fmul    dword ptr -34H[ebp]
                mov     eax,dword ptr -8H[ebp]
                fadd    dword ptr +40H[eax]
                fstp    dword ptr -28H[ebp]
                mov     eax,dword ptr -0cH[ebp]
                fld     dword ptr +44H[eax]
                fmul    dword ptr -34H[ebp]
                mov     eax,dword ptr -0cH[ebp]
                fadd    dword ptr +40H[eax]
                fstp    dword ptr -2cH[ebp]
L93:            fld     dword ptr -2cH[ebp]
                fcomp   dword ptr -28H[ebp]
                fstsw   ax
                sahf    
                jb      near ptr L96
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                add     eax,0000ffffH
                sar     eax,10H
                mov     dword ptr -38H[ebp],eax
                mov     eax,dword ptr -8H[ebp]
                mov     edx,dword ptr +34H[eax]
                mov     eax,dword ptr -10H[ebp]
                mov     ebx,dword ptr -38H[ebp]
                sub     ebx,edx
                mov     dword ptr +0cH[eax],ebx
                mov     eax,dword ptr -10H[ebp]
                cmp     dword ptr +0cH[eax],00000000H
                jle     near ptr L95
                mov     eax,dword ptr -30H[ebp]
                mov     edx,dword ptr -10H[ebp]
                mov     dword ptr +4H[edx],eax
                mov     eax,dword ptr -8H[ebp]
                mov     edx,dword ptr +34H[eax]
                mov     eax,dword ptr -10H[ebp]
                mov     dword ptr [eax],edx
                mov     eax,dword ptr -10H[ebp]
                fild    dword ptr [eax]
                mov     eax,dword ptr -8H[ebp]
                fmul    dword ptr +44H[eax]
                mov     eax,dword ptr -8H[ebp]
                fadd    dword ptr +40H[eax]
                mov     eax,dword ptr -10H[ebp]
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr +8H[eax]
                mov     eax,dword ptr -8H[ebp]
                fldz    
                fcomp   dword ptr +44H[eax]
                fstsw   ax
                sahf    
                jae     short L94
                mov     eax,dword ptr -10H[ebp]
                mov     eax,dword ptr [eax]
                mov     edx,dword ptr -10H[ebp]
                add     eax,dword ptr +0cH[edx]
                mov     dword ptr -60H[ebp],eax
                fild    dword ptr -60H[ebp]
                mov     eax,dword ptr -8H[ebp]
                fmul    dword ptr +44H[eax]
                mov     eax,dword ptr -8H[ebp]
                fadd    dword ptr +40H[eax]
                mov     eax,dword ptr -10H[ebp]
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr +8H[eax]
L94:            mov     esi,dword ptr -8H[ebp]
                mov     edi,dword ptr +8H[esi]
                mov     esi,dword ptr -10H[ebp]
                mov     dword ptr +34H[esi],edi
                mov     edi,dword ptr -10H[ebp]
                lea     edi,+10H[edi]
                mov     esi,dword ptr -8H[ebp]
                lea     esi,+0cH[esi]
                movsd   
                movsd   
                movsd   
                mov     edi,dword ptr -10H[ebp]
                lea     edi,+1cH[edi]
                mov     esi,dword ptr -8H[ebp]
                lea     esi,+18H[esi]
                movsd   
                movsd   
                movsd   
                mov     edi,dword ptr -10H[ebp]
                lea     edi,+28H[edi]
                mov     esi,dword ptr -8H[ebp]
                lea     esi,+24H[esi]
                movsd   
                movsd   
                movsd   
                mov     esi,offset DGROUP:_spans+111700H
                cmp     esi,dword ptr -10H[ebp]
                jbe     short L95
                mov     eax,dword ptr -10H[ebp]
                add     dword ptr -10H[ebp],00000038H
L95:            mov     eax,dword ptr -38H[ebp]
                mov     edx,dword ptr -0cH[ebp]
                mov     dword ptr +34H[edx],eax
                mov     eax,dword ptr -8H[ebp]
                mov     edx,dword ptr -0cH[ebp]
                mov     dword ptr [edx],eax
                mov     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr -8H[ebp]
                mov     dword ptr +4H[edx],eax
                mov     eax,dword ptr -0cH[ebp]
                mov     dword ptr _surfstack,eax
                mov     eax,dword ptr -0cH[ebp]
                mov     dword ptr +4H[eax],offset DGROUP:_surfstack
                jmp     near ptr L101
L96:            mov     eax,dword ptr -8H[ebp]
                mov     eax,dword ptr [eax]
                mov     dword ptr -8H[ebp],eax
                mov     eax,dword ptr -0cH[ebp]
                cmp     dword ptr +30H[eax],0ffffffffH
                je      short L97
                mov     eax,dword ptr -8H[ebp]
                cmp     dword ptr +30H[eax],0ffffffffH
                jne     short L98
L97:            jmp     short L99
L98:            mov     eax,dword ptr -8H[ebp]
                fild    dword ptr +30H[eax]
                fstp    dword ptr -28H[ebp]
                mov     eax,dword ptr -0cH[ebp]
                fild    dword ptr +30H[eax]
                fstp    dword ptr -2cH[ebp]
                jmp     short L100
L99:            mov     eax,dword ptr -8H[ebp]
                fld     dword ptr +44H[eax]
                fmul    dword ptr -34H[ebp]
                mov     eax,dword ptr -8H[ebp]
                fadd    dword ptr +40H[eax]
                fstp    dword ptr -28H[ebp]
                mov     eax,dword ptr -0cH[ebp]
                fld     dword ptr +44H[eax]
                fmul    dword ptr -34H[ebp]
                mov     eax,dword ptr -0cH[ebp]
                fadd    dword ptr +40H[eax]
                fstp    dword ptr -2cH[ebp]
L100:           fld     dword ptr -2cH[ebp]
                fcomp   dword ptr -28H[ebp]
                fstsw   ax
                sahf    
                jb      short L96
                mov     eax,dword ptr -8H[ebp]
                mov     edx,dword ptr -0cH[ebp]
                mov     dword ptr [edx],eax
                mov     eax,dword ptr -8H[ebp]
                mov     edx,dword ptr +4H[eax]
                mov     eax,dword ptr -0cH[ebp]
                mov     dword ptr +4H[eax],edx
                mov     eax,dword ptr -8H[ebp]
                mov     edx,dword ptr +4H[eax]
                mov     eax,dword ptr -0cH[ebp]
                mov     dword ptr [edx],eax
                mov     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr -8H[ebp]
                mov     dword ptr +4H[edx],eax
L101:           jmp     near ptr L106
L102:           mov     eax,dword ptr -0cH[ebp]
                dec     dword ptr +38H[eax]
                mov     eax,dword ptr -0cH[ebp]
                cmp     dword ptr +38H[eax],00000000H
                jne     near ptr L106
                mov     eax,dword ptr _surfstack
                cmp     eax,dword ptr -0cH[ebp]
                jne     near ptr L105
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                add     eax,0000ffffH
                sar     eax,10H
                mov     dword ptr -38H[ebp],eax
                mov     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr +34H[eax]
                mov     eax,dword ptr -10H[ebp]
                mov     ebx,dword ptr -38H[ebp]
                sub     ebx,edx
                mov     dword ptr +0cH[eax],ebx
                mov     eax,dword ptr -10H[ebp]
                cmp     dword ptr +0cH[eax],00000000H
                jle     near ptr L104
                mov     eax,dword ptr -30H[ebp]
                mov     edx,dword ptr -10H[ebp]
                mov     dword ptr +4H[edx],eax
                mov     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr +34H[eax]
                mov     eax,dword ptr -10H[ebp]
                mov     dword ptr [eax],edx
                mov     eax,dword ptr -10H[ebp]
                fild    dword ptr [eax]
                mov     eax,dword ptr -0cH[ebp]
                fmul    dword ptr +44H[eax]
                mov     eax,dword ptr -0cH[ebp]
                fadd    dword ptr +40H[eax]
                mov     eax,dword ptr -10H[ebp]
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr +8H[eax]
                mov     eax,dword ptr -0cH[ebp]
                fldz    
                fcomp   dword ptr +44H[eax]
                fstsw   ax
                sahf    
                jae     short L103
                mov     eax,dword ptr -10H[ebp]
                mov     eax,dword ptr [eax]
                mov     edx,dword ptr -10H[ebp]
                add     eax,dword ptr +0cH[edx]
                mov     dword ptr -60H[ebp],eax
                fild    dword ptr -60H[ebp]
                mov     eax,dword ptr -0cH[ebp]
                fmul    dword ptr +44H[eax]
                mov     eax,dword ptr -0cH[ebp]
                fadd    dword ptr +40H[eax]
                mov     eax,dword ptr -10H[ebp]
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr +8H[eax]
L103:           mov     esi,dword ptr -0cH[ebp]
                mov     edi,dword ptr +8H[esi]
                mov     esi,dword ptr -10H[ebp]
                mov     dword ptr +34H[esi],edi
                mov     edi,dword ptr -10H[ebp]
                lea     edi,+10H[edi]
                mov     esi,dword ptr -0cH[ebp]
                lea     esi,+0cH[esi]
                movsd   
                movsd   
                movsd   
                mov     edi,dword ptr -10H[ebp]
                lea     edi,+1cH[edi]
                mov     esi,dword ptr -0cH[ebp]
                lea     esi,+18H[esi]
                movsd   
                movsd   
                movsd   
                mov     edi,dword ptr -10H[ebp]
                lea     edi,+28H[edi]
                mov     esi,dword ptr -0cH[ebp]
                lea     esi,+24H[esi]
                movsd   
                movsd   
                movsd   
                mov     esi,offset DGROUP:_spans+111700H
                cmp     esi,dword ptr -10H[ebp]
                jbe     short L104
                mov     eax,dword ptr -10H[ebp]
                add     dword ptr -10H[ebp],00000038H
L104:           mov     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr [eax]
                mov     eax,dword ptr -38H[ebp]
                mov     dword ptr +34H[edx],eax
L105:           mov     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr [eax]
                mov     eax,dword ptr -0cH[ebp]
                mov     eax,dword ptr +4H[eax]
                mov     dword ptr +4H[edx],eax
                mov     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr +4H[eax]
                mov     eax,dword ptr -0cH[ebp]
                mov     eax,dword ptr [eax]
                mov     dword ptr [edx],eax
L106:           jmp     near ptr L78
L107:           mov     eax,dword ptr -30H[ebp]
                shl     eax,02H
                mov     eax,dword ptr _removeedges[eax]
                mov     dword ptr -24H[ebp],eax
L108:           cmp     dword ptr -24H[ebp],00000000H
                je      short L109
                mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr +1cH[eax]
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr +18H[edx],eax
                mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr +18H[eax]
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +1cH[eax]
                mov     dword ptr +1cH[edx],eax
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +20H[eax]
                mov     dword ptr -24H[ebp],eax
                jmp     short L108
L109:           mov     eax,dword ptr _edgehead+18H
                mov     dword ptr -24H[ebp],eax
L110:           mov     eax,offset DGROUP:_edgetail
                cmp     eax,dword ptr -24H[ebp]
                jne     short L112
                jmp     near ptr L115
L111:           jmp     short L110
L112:           mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +18H[eax]
                mov     dword ptr -1cH[ebp],eax
                mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr +4H[eax]
                mov     eax,dword ptr -24H[ebp]
                add     dword ptr [eax],edx
                mov     eax,dword ptr -24H[ebp]
                fld     dword ptr +10H[eax]
                mov     eax,dword ptr -24H[ebp]
                fadd    dword ptr +0cH[eax]
                fstp    dword ptr +0cH[eax]
L113:           mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr +1cH[eax]
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr [eax]
                cmp     eax,dword ptr [edx]
                jge     short L114
                mov     eax,dword ptr -24H[ebp]
                mov     eax,dword ptr +1cH[eax]
                mov     dword ptr -20H[ebp],eax
                mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr +18H[eax]
                mov     eax,dword ptr -20H[ebp]
                mov     dword ptr +18H[eax],edx
                mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr +18H[eax]
                mov     eax,dword ptr -20H[ebp]
                mov     dword ptr +1cH[edx],eax
                mov     eax,dword ptr -20H[ebp]
                mov     edx,dword ptr +1cH[eax]
                mov     eax,dword ptr -24H[ebp]
                mov     dword ptr +18H[edx],eax
                mov     eax,dword ptr -20H[ebp]
                mov     edx,dword ptr +1cH[eax]
                mov     eax,dword ptr -24H[ebp]
                mov     dword ptr +1cH[eax],edx
                mov     eax,dword ptr -20H[ebp]
                mov     edx,dword ptr -24H[ebp]
                mov     dword ptr +18H[edx],eax
                mov     eax,dword ptr -24H[ebp]
                mov     edx,dword ptr -20H[ebp]
                mov     dword ptr +1cH[edx],eax
                jmp     short L113
L114:           mov     eax,dword ptr -1cH[ebp]
                mov     dword ptr -24H[ebp],eax
                jmp     near ptr L111
L115:           jmp     near ptr L71
L116:           mov     eax,dword ptr -10H[ebp]
                mov     dword ptr [eax],0ffffffffH
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
ClearEdgeLists_: push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000004H
                mov     dword ptr -4H[ebp],00000000H
L117:           mov     eax,dword ptr -4H[ebp]
                cmp     eax,dword ptr _DIBHeight
                jl      short L119
                jmp     short L120
L118:           mov     eax,dword ptr -4H[ebp]
                inc     dword ptr -4H[ebp]
                jmp     short L117
L119:           imul    eax,dword ptr -4H[ebp],24H
                mov     dword ptr _newedges+18H[eax],offset DGROUP:_maxedge
                mov     eax,dword ptr -4H[ebp]
                shl     eax,02H
                mov     dword ptr _removeedges[eax],00000000H
                jmp     short L118
L120:           mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
addpolygon_:    push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,000005a0H
                mov     dword ptr -4H[ebp],eax
                push    dword ptr _currentpos+8H
                push    dword ptr _currentpos+4H
                push    dword ptr _currentpos
                mov     edx,dword ptr -4H[ebp]
                add     edx,0000012cH
                mov     eax,dword ptr -4H[ebp]
                call    near ptr PolyFacesViewer_
                test    eax,eax
                je      near ptr L121
                lea     edx,-2b0H[ebp]
                mov     eax,dword ptr -4H[ebp]
                call    near ptr ClipToFrustum_
                test    eax,eax
                je      near ptr L121
                mov     edi,dword ptr -4H[ebp]
                mov     eax,dword ptr [edi]
                mov     dword ptr _currentcolor,eax
                mov     edi,dword ptr -4H[ebp]
                mov     eax,dword ptr +4cH[edi]
                mov     dword ptr _currentbspdepth,eax
                lea     edx,-528H[ebp]
                lea     eax,-2b0H[ebp]
                call    near ptr TransformPolygon_
                lea     edx,-3ecH[ebp]
                mov     eax,dword ptr -4H[ebp]
                call    near ptr TransformPolygon_
                lea     edx,-48H[ebp]
                mov     eax,dword ptr -4H[ebp]
                add     eax,00000004H
                call    near ptr TransformvPoint_
                lea     edx,-70H[ebp]
                mov     eax,dword ptr -4H[ebp]
                add     eax,00000010H
                call    near ptr TransformvPoint_
                lea     edx,-98H[ebp]
                mov     eax,dword ptr -4H[ebp]
                add     eax,0000001cH
                call    near ptr TransformvPoint_
                mov     ecx,0000000aH
                lea     edi,-550H[ebp]
                lea     esi,-48H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-550H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-550H[ebp]
                lea     esi,-70H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-550H[ebp]
                repe    movsd    
                lea     esi,-578H[ebp]
                call    near ptr vectorsubtract_
                mov     ecx,0000000aH
                lea     edi,-70H[ebp]
                lea     esi,-578H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-550H[ebp]
                lea     esi,-48H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-550H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-550H[ebp]
                lea     esi,-98H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-550H[ebp]
                repe    movsd    
                lea     esi,-5a0H[ebp]
                call    near ptr vectorsubtract_
                mov     ecx,0000000aH
                lea     edi,-98H[ebp]
                lea     esi,-5a0H[ebp]
                repe    movsd    
                fld     dword ptr -48H[ebp]
                fmul    dword ptr _maxscale
                fstp    dword ptr -48H[ebp]
                fld     dword ptr -70H[ebp]
                fmul    dword ptr _maxscale
                fstp    dword ptr -70H[ebp]
                fld     dword ptr -98H[ebp]
                fmul    dword ptr _maxscale
                fstp    dword ptr -98H[ebp]
                fld     dword ptr _maxscale
                fchs    
                fmul    dword ptr -44H[ebp]
                fstp    dword ptr -44H[ebp]
                fld     dword ptr _maxscale
                fchs    
                fmul    dword ptr -6cH[ebp]
                fstp    dword ptr -6cH[ebp]
                fld     dword ptr _maxscale
                fchs    
                fmul    dword ptr -94H[ebp]
                fstp    dword ptr -94H[ebp]
                mov     ebx,offset DGROUP:_A
                lea     edx,-98H[ebp]
                lea     eax,-48H[ebp]
                call    near ptr CrossvProduct_
                mov     ebx,offset DGROUP:_B
                lea     edx,-48H[ebp]
                lea     eax,-70H[ebp]
                call    near ptr CrossvProduct_
                mov     ebx,offset DGROUP:_C
                lea     edx,-70H[ebp]
                lea     eax,-98H[ebp]
                call    near ptr CrossvProduct_
                lea     edx,-174H[ebp]
                lea     eax,-528H[ebp]
                call    near ptr ProjectPolygon_
                lea     edi,-10H[ebp]
                mov     esi,dword ptr -4H[ebp]
                lea     esi,+130H[esi]
                movsd   
                movsd   
                movsd   
                mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +12cH[eax]
                mov     dword ptr -20H[ebp],eax
                lea     edx,-10H[ebp]
                mov     eax,offset DGROUP:_currentpos
                call    near ptr DotProduct_
                fsubr   dword ptr -20H[ebp]
                fstp    dword ptr -20H[ebp]
                mov     edx,offset DGROUP:_vright
                lea     eax,-10H[ebp]
                call    near ptr DotProduct_
                fstp    dword ptr -1cH[ebp]
                mov     edx,offset DGROUP:_vup
                lea     eax,-10H[ebp]
                call    near ptr DotProduct_
                fstp    dword ptr -18H[ebp]
                mov     edx,offset DGROUP:_vpn
                lea     eax,-10H[ebp]
                call    near ptr DotProduct_
                fstp    dword ptr -14H[ebp]
                lea     edx,-174H[ebp]
                lea     eax,-20H[ebp]
                call    near ptr AddPolygonEdges_
                inc     dword ptr _currentbspdepth
L121:           mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
InitPos_:       push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000004H
                mov     dword ptr _gravitationspeed,00000000H
                mov     dword ptr _gravitationaccel,3e99999aH
                mov     dword ptr _playerspeedscale,3f800000H
                mov     dword ptr _speedscale,3f800000H
                mov     dword ptr _roll,00000000H
                mov     dword ptr _pitch,00000000H
                mov     dword ptr _yaw,3f6bcd36H
                mov     dword ptr _yawspeed,00000000H
                mov     dword ptr _currentspeed,00000000H
                mov     dword ptr _currentcolor,0ffffffffH
                mov     edi,offset DGROUP:_currentpos
                mov     esi,offset DGROUP:_startpos
                movsd   
                movsd   
                movsd   
                fld     dword ptr _yawspeed
                fstp    dword ptr _playeryawspeed
                fld     dword ptr _yaw
                fstp    dword ptr _playeryaw
                fld     dword ptr _roll
                fstp    dword ptr _playerroll
                mov     edi,offset DGROUP:_playercurrentpos
                mov     esi,offset DGROUP:_currentpos
                movsd   
                movsd   
                movsd   
                fld     dword ptr _pitch
                fstp    dword ptr _playerpitch
                mov     dword ptr -4H[ebp],00000000H
                mov     eax,dword ptr -4H[ebp]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
InitDraw_:      push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000008H
                mov     dword ptr _mip,00000000H
                mov     eax,dword ptr _INITIAL_WINDOW_WIDTH
                mov     dword ptr _DIBWidth,eax
                mov     eax,dword ptr _INITIAL_WINDOW_HEIGHT
                mov     dword ptr _DIBHeight,eax
                mov     eax,dword ptr _INITIAL_DIB_WIDTH
                mov     dword ptr _DIBPitch,eax
                mov     dword ptr _WindowOffsetX,00000000H
                mov     dword ptr _WindowOffsetY,00000000H
                mov     dword ptr _fieldofview,40000000H
                fild    dword ptr _DIBWidth
                fld     dword ptr _fieldofview
                fdivp   st(1),st
                fstp    dword ptr _xscreenscale
                fild    dword ptr _DIBHeight
                fld     dword ptr _fieldofview
                fdivp   st(1),st
                fstp    dword ptr _yscreenscale
                fld     dword ptr _xscreenscale
                fcomp   dword ptr _yscreenscale
                fstsw   ax
                sahf    
                jbe     short L122
                mov     eax,dword ptr _xscreenscale
                mov     dword ptr -8H[ebp],eax
                jmp     short L123
L122:           mov     eax,dword ptr _yscreenscale
                mov     dword ptr -8H[ebp],eax
L123:           mov     eax,dword ptr -8H[ebp]
                mov     dword ptr _maxscale,eax
                fld     dword ptr _maxscale
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr _maxscreenscaleinv
                fild    dword ptr _DIBWidth
                fmul    qword ptr L242
                fadd    qword ptr L243
                fstp    dword ptr _xcenter
                fild    dword ptr _DIBHeight
                fmul    qword ptr L242
                fadd    qword ptr L243
                fstp    dword ptr _ycenter
                mov     dword ptr _RUN_LENGTH,00000008H
                mov     dword ptr _RUN_LENGTHEXP,00000003H
                mov     eax,dword ptr _currentMode
                shl     eax,02H
                cmp     dword ptr _modeMenu[eax],0ffffffffH
                jne     short L124
                mov     dword ptr _screenbuffer,000a0000H
                mov     eax,dword ptr _INITIAL_DIB_WIDTH
                imul    eax,dword ptr _INITIAL_DIB_HEIGHT
                xor     edx,edx
                mov     ecx,dword ptr _screenbuffer
                mov     ebx,eax
                mov     eax,ecx
                call    near ptr memset_
                jmp     short L125
L124:           mov     eax,offset DGROUP:_coockieModeInfo
                call    near ptr coockie_getLinearSelector_
                and     eax,0000ffffH
                mov     dword ptr _coockieGS,eax
                mov     eax,dword ptr _coockieGS
                mov     gs,ax
                push    00000000H
                call    dword ptr _SV_clear
                add     esp,00000004H
L125:           mov     dword ptr -4H[ebp],00000000H
                mov     eax,dword ptr -4H[ebp]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
UpdateDraw_:    push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000008H
                mov     dword ptr _mip,00000000H
                mov     dword ptr _fieldofview,40000000H
                fild    dword ptr _DIBWidth
                fld     dword ptr _fieldofview
                fdivp   st(1),st
                fstp    dword ptr _xscreenscale
                fild    dword ptr _DIBHeight
                fld     dword ptr _fieldofview
                fdivp   st(1),st
                fstp    dword ptr _yscreenscale
                fld     dword ptr _xscreenscale
                fcomp   dword ptr _yscreenscale
                fstsw   ax
                sahf    
                jbe     short L126
                mov     eax,dword ptr _xscreenscale
                mov     dword ptr -8H[ebp],eax
                jmp     short L127
L126:           mov     eax,dword ptr _yscreenscale
                mov     dword ptr -8H[ebp],eax
L127:           mov     eax,dword ptr -8H[ebp]
                mov     dword ptr _maxscale,eax
                fld     dword ptr _maxscale
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr _maxscreenscaleinv
                fild    dword ptr _DIBWidth
                fmul    qword ptr L244
                fadd    qword ptr L245
                fstp    dword ptr _xcenter
                fild    dword ptr _DIBHeight
                fmul    qword ptr L244
                fadd    qword ptr L245
                fstp    dword ptr _ycenter
                mov     dword ptr _RUN_LENGTH,00000008H
                mov     dword ptr _RUN_LENGTHEXP,00000003H
                mov     eax,dword ptr _currentMode
                shl     eax,02H
                cmp     dword ptr _modeMenu[eax],0ffffffffH
                jne     short L128
                mov     dword ptr _screenbuffer,000a0000H
                mov     eax,dword ptr _INITIAL_DIB_WIDTH
                imul    eax,dword ptr _INITIAL_DIB_HEIGHT
                xor     edx,edx
                mov     ecx,dword ptr _screenbuffer
                mov     ebx,eax
                mov     eax,ecx
                call    near ptr memset_
                jmp     short L129
L128:           mov     eax,offset DGROUP:_coockieModeInfo
                call    near ptr coockie_getLinearSelector_
                and     eax,0000ffffH
                mov     dword ptr _coockieGS,eax
                mov     eax,dword ptr _coockieGS
                mov     gs,ax
                push    00000000H
                call    dword ptr _SV_clear
                add     esp,00000004H
L129:           mov     dword ptr -4H[ebp],00000000H
                mov     eax,dword ptr -4H[ebp]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
ProjectPolygon_: push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000010H
                mov     dword ptr -10H[ebp],eax
                mov     dword ptr -0cH[ebp],edx
                mov     dword ptr -8H[ebp],00000000H
L130:           mov     eax,dword ptr -8H[ebp]
                mov     edx,dword ptr -10H[ebp]
                cmp     eax,dword ptr +50H[edx]
                jl      short L132
                jmp     short L133
L131:           mov     eax,dword ptr -8H[ebp]
                inc     dword ptr -8H[ebp]
                jmp     short L130
L132:           imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -10H[ebp]
                fld     dword ptr +5cH[eax]
                fld1    
                fdivrp  st(1),st
                fstp    dword ptr -4H[ebp]
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -10H[ebp]
                fld     dword ptr +54H[eax]
                fmul    dword ptr -4H[ebp]
                fmul    dword ptr _maxscale
                fadd    dword ptr _xcenter
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -0cH[ebp]
                fstp    dword ptr +4H[eax]
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -10H[ebp]
                fld     dword ptr +58H[eax]
                fmul    dword ptr -4H[ebp]
                fmul    dword ptr _maxscale
                fsubr   dword ptr _ycenter
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -0cH[ebp]
                fstp    dword ptr +8H[eax]
                imul    eax,dword ptr -8H[ebp],0cH
                add     eax,dword ptr -10H[ebp]
                imul    edx,dword ptr -8H[ebp],0cH
                add     edx,dword ptr -0cH[ebp]
                fld     dword ptr +5cH[eax]
                fstp    dword ptr +0cH[edx]
                jmp     short L131
L133:           mov     eax,dword ptr -10H[ebp]
                mov     edx,dword ptr +50H[eax]
                mov     eax,dword ptr -0cH[ebp]
                mov     dword ptr [eax],edx
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     
BackRotateVector_:
                push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,0000000cH
                mov     dword ptr -0cH[ebp],eax
                mov     dword ptr -8H[ebp],edx
                mov     dword ptr -4H[ebp],00000000H
L134:           cmp     dword ptr -4H[ebp],00000003H
                jl      short L136
                jmp     short L137
L135:           mov     eax,dword ptr -4H[ebp]
                inc     dword ptr -4H[ebp]
                jmp     short L134
L136:           mov     edx,dword ptr -4H[ebp]
                shl     edx,02H
                mov     eax,dword ptr -0cH[ebp]
                fld     dword ptr +4H[eax]
                fmul    dword ptr _vup[edx]
                mov     edx,dword ptr -4H[ebp]
                shl     edx,02H
                mov     eax,dword ptr -0cH[ebp]
                fld     dword ptr [eax]
                fmul    dword ptr _vright[edx]
                faddp   st(1),st
                mov     edx,dword ptr -4H[ebp]
                shl     edx,02H
                mov     eax,dword ptr -0cH[ebp]
                fld     dword ptr +8H[eax]
                fmul    dword ptr _vpn[edx]
                faddp   st(1),st
                mov     eax,dword ptr -4H[ebp]
                shl     eax,02H
                add     eax,dword ptr -8H[ebp]
                fstp    dword ptr [eax]
                jmp     short L135
L137:           mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     
TransformPoint_: push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000018H
                mov     dword ptr -0cH[ebp],eax
                mov     dword ptr -4H[ebp],edx
                mov     dword ptr -8H[ebp],00000000H
L138:           cmp     dword ptr -8H[ebp],00000003H
                jl      short L140
                jmp     short L141
L139:           mov     eax,dword ptr -8H[ebp]
                inc     dword ptr -8H[ebp]
                jmp     short L138
L140:           mov     eax,dword ptr -8H[ebp]
                shl     eax,02H
                add     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr -8H[ebp]
                shl     edx,02H
                fld     dword ptr [eax]
                fsub    dword ptr _currentpos[edx]
                mov     eax,dword ptr -8H[ebp]
                shl     eax,02H
                fstp    dword ptr -18H[eax+ebp]
                jmp     short L139
L141:           mov     edx,offset DGROUP:_vright
                lea     eax,-18H[ebp]
                call    near ptr DotProduct_
                mov     eax,dword ptr -4H[ebp]
                fstp    dword ptr [eax]
                mov     edx,offset DGROUP:_vup
                lea     eax,-18H[ebp]
                call    near ptr DotProduct_
                mov     eax,dword ptr -4H[ebp]
                fstp    dword ptr +4H[eax]
                mov     edx,offset DGROUP:_vpn
                lea     eax,-18H[ebp]
                call    near ptr DotProduct_
                mov     eax,dword ptr -4H[ebp]
                fstp    dword ptr +8H[eax]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     
TransformvPoint_:
                push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000018H
                mov     dword ptr -0cH[ebp],eax
                mov     dword ptr -4H[ebp],edx
                mov     dword ptr -8H[ebp],00000000H
L142:           cmp     dword ptr -8H[ebp],00000003H
                jl      short L144
                jmp     short L145
L143:           mov     eax,dword ptr -8H[ebp]
                inc     dword ptr -8H[ebp]
                jmp     short L142
L144:           mov     eax,dword ptr -8H[ebp]
                shl     eax,02H
                add     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr -8H[ebp]
                shl     edx,02H
                fld     dword ptr [eax]
                fsub    dword ptr _currentpos[edx]
                mov     eax,dword ptr -8H[ebp]
                shl     eax,02H
                fstp    dword ptr -18H[eax+ebp]
                jmp     short L143
L145:           mov     edx,offset DGROUP:_vright
                lea     eax,-18H[ebp]
                call    near ptr DotProduct_
                mov     eax,dword ptr -4H[ebp]
                fstp    dword ptr [eax]
                mov     edx,offset DGROUP:_vup
                lea     eax,-18H[ebp]
                call    near ptr DotProduct_
                mov     eax,dword ptr -4H[ebp]
                fstp    dword ptr +4H[eax]
                mov     edx,offset DGROUP:_vpn
                lea     eax,-18H[ebp]
                call    near ptr DotProduct_
                mov     eax,dword ptr -4H[ebp]
                fstp    dword ptr +8H[eax]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     
TransformPolygon_:
                push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,0000000cH
                mov     dword ptr -0cH[ebp],eax
                mov     dword ptr -8H[ebp],edx
                mov     dword ptr -4H[ebp],00000000H
L146:           mov     eax,dword ptr -4H[ebp]
                mov     edx,dword ptr -0cH[ebp]
                cmp     eax,dword ptr +50H[edx]
                jl      short L148
                jmp     short L149
L147:           mov     eax,dword ptr -4H[ebp]
                inc     dword ptr -4H[ebp]
                jmp     short L146
L148:           imul    edx,dword ptr -4H[ebp],0cH
                mov     eax,dword ptr -8H[ebp]
                add     eax,00000054H
                add     edx,eax
                imul    ebx,dword ptr -4H[ebp],0cH
                mov     eax,dword ptr -0cH[ebp]
                add     eax,00000054H
                add     eax,ebx
                call    near ptr TransformPoint_
                jmp     short L147
L149:           mov     eax,dword ptr -0cH[ebp]
                mov     edx,dword ptr +50H[eax]
                mov     eax,dword ptr -8H[ebp]
                mov     dword ptr +50H[eax],edx
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     
PolyFacesViewer_:
                push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,0000001cH
                mov     dword ptr -10H[ebp],eax
                mov     dword ptr -8H[ebp],edx
                mov     dword ptr -0cH[ebp],00000000H
L150:           cmp     dword ptr -0cH[ebp],00000003H
                jl      short L152
                jmp     short L153
L151:           mov     eax,dword ptr -0cH[ebp]
                inc     dword ptr -0cH[ebp]
                jmp     short L150
L152:           mov     eax,dword ptr -0cH[ebp]
                shl     eax,02H
                add     eax,dword ptr -10H[ebp]
                mov     edx,dword ptr -0cH[ebp]
                shl     edx,02H
                fld     dword ptr +54H[eax]
                fsub    dword ptr +18H[edx+ebp]
                mov     eax,dword ptr -0cH[ebp]
                shl     eax,02H
                fstp    dword ptr -1cH[eax+ebp]
                jmp     short L151
L153:           mov     edx,dword ptr -8H[ebp]
                add     edx,00000004H
                lea     eax,-1cH[ebp]
                call    near ptr DotProduct_
                fcomp   qword ptr L246
                fstsw   ax
                sahf    
                jae     short L154
                mov     dword ptr -4H[ebp],00000001H
                jmp     short L155
L154:           mov     dword ptr -4H[ebp],00000000H
L155:           mov     eax,dword ptr -4H[ebp]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     000cH
SetWorldspaceClipPlane_:
                push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000008H
                mov     dword ptr -8H[ebp],eax
                mov     dword ptr -4H[ebp],edx
                mov     edx,dword ptr -4H[ebp]
                add     edx,00000004H
                mov     eax,dword ptr -8H[ebp]
                call    near ptr BackRotateVector_
                mov     edx,dword ptr -4H[ebp]
                add     edx,00000004H
                mov     eax,offset DGROUP:_currentpos
                call    near ptr DotProduct_
                fadd    qword ptr L247
                mov     eax,dword ptr -4H[ebp]
                fstp    dword ptr [eax]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     
SetUpFrustum_:  push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000018H
                fld     dword ptr _fieldofview
                fdivr   qword ptr L248
                fld     dword ptr _maxscale
                fmulp   st(1),st
                fld     dword ptr _xscreenscale
                fdivp   st(1),st
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr atan_
                fstp    dword ptr -0cH[ebp]
                fld     dword ptr -0cH[ebp]
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr sin_
                fstp    dword ptr -4H[ebp]
                fld     dword ptr -0cH[ebp]
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr cos_
                fstp    dword ptr -8H[ebp]
                mov     eax,dword ptr -4H[ebp]
                mov     dword ptr -18H[ebp],eax
                mov     dword ptr -14H[ebp],00000000H
                mov     eax,dword ptr -8H[ebp]
                mov     dword ptr -10H[ebp],eax
                mov     edx,offset DGROUP:_frustumplanes
                lea     eax,-18H[ebp]
                call    near ptr SetWorldspaceClipPlane_
                fld     dword ptr -4H[ebp]
                fchs    
                fstp    dword ptr -18H[ebp]
                mov     edx,offset DGROUP:_frustumplanes+10H
                lea     eax,-18H[ebp]
                call    near ptr SetWorldspaceClipPlane_
                fld     dword ptr _fieldofview
                fdivr   qword ptr L248
                fld     dword ptr _maxscale
                fmulp   st(1),st
                fld     dword ptr _yscreenscale
                fdivp   st(1),st
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr atan_
                fstp    dword ptr -0cH[ebp]
                fld     dword ptr -0cH[ebp]
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr sin_
                fstp    dword ptr -4H[ebp]
                fld     dword ptr -0cH[ebp]
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr cos_
                fstp    dword ptr -8H[ebp]
                mov     dword ptr -18H[ebp],00000000H
                mov     eax,dword ptr -4H[ebp]
                mov     dword ptr -14H[ebp],eax
                mov     eax,dword ptr -8H[ebp]
                mov     dword ptr -10H[ebp],eax
                mov     edx,offset DGROUP:_frustumplanes+20H
                lea     eax,-18H[ebp]
                call    near ptr SetWorldspaceClipPlane_
                fld     dword ptr -4H[ebp]
                fchs    
                fstp    dword ptr -14H[ebp]
                mov     edx,offset DGROUP:_frustumplanes+30H
                lea     eax,-18H[ebp]
                call    near ptr SetWorldspaceClipPlane_
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
ClipToPlane_:   push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000040H
                mov     dword ptr -38H[ebp],eax
                mov     dword ptr -34H[ebp],edx
                mov     dword ptr -30H[ebp],ebx
                mov     eax,dword ptr -38H[ebp]
                add     eax,00000054H
                mov     dword ptr -0cH[ebp],eax
                mov     eax,dword ptr -30H[ebp]
                add     eax,00000054H
                mov     dword ptr -8H[ebp],eax
                mov     edx,dword ptr -34H[ebp]
                add     edx,00000004H
                mov     eax,dword ptr -0cH[ebp]
                call    near ptr DotProduct_
                fstp    dword ptr -18H[ebp]
                mov     eax,dword ptr -34H[ebp]
                fld     dword ptr -18H[ebp]
                fcomp   dword ptr [eax]
                fstsw   ax
                sahf    
                jb      short L156
                mov     dword ptr -3cH[ebp],00000001H
                jmp     short L157
L156:           mov     dword ptr -3cH[ebp],00000000H
L157:           mov     eax,dword ptr -3cH[ebp]
                mov     dword ptr -20H[ebp],eax
                mov     dword ptr -2cH[ebp],00000000H
L158:           mov     eax,dword ptr -2cH[ebp]
                mov     edx,dword ptr -38H[ebp]
                cmp     eax,dword ptr +50H[edx]
                jl      short L160
                jmp     near ptr L169
L159:           mov     eax,dword ptr -2cH[ebp]
                inc     dword ptr -2cH[ebp]
                jmp     short L158
L160:           mov     edx,dword ptr -2cH[ebp]
                inc     edx
                mov     eax,edx
                sar     edx,1fH
                mov     ebx,dword ptr -38H[ebp]
                idiv    dword ptr +50H[ebx]
                mov     dword ptr -24H[ebp],edx
                cmp     dword ptr -20H[ebp],00000000H
                je      short L161
                mov     edi,dword ptr -8H[ebp]
                add     dword ptr -8H[ebp],0000000cH
                mov     esi,dword ptr -0cH[ebp]
                movsd   
                movsd   
                movsd   
L161:           mov     edx,dword ptr -34H[ebp]
                add     edx,00000004H
                imul    ebx,dword ptr -24H[ebp],0cH
                mov     eax,dword ptr -38H[ebp]
                add     eax,00000054H
                add     eax,ebx
                call    near ptr DotProduct_
                fstp    dword ptr -14H[ebp]
                mov     eax,dword ptr -34H[ebp]
                fld     dword ptr -14H[ebp]
                fcomp   dword ptr [eax]
                fstsw   ax
                sahf    
                jb      short L162
                mov     dword ptr -40H[ebp],00000001H
                jmp     short L163
L162:           mov     dword ptr -40H[ebp],00000000H
L163:           mov     eax,dword ptr -40H[ebp]
                mov     dword ptr -1cH[ebp],eax
                mov     eax,dword ptr -20H[ebp]
                cmp     eax,dword ptr -1cH[ebp]
                je      short L168
                mov     eax,dword ptr -34H[ebp]
                fld     dword ptr [eax]
                fsub    dword ptr -18H[ebp]
                fld     dword ptr -14H[ebp]
                fsub    dword ptr -18H[ebp]
                fdivp   st(1),st
                fstp    dword ptr -10H[ebp]
                mov     dword ptr -28H[ebp],00000000H
L164:           cmp     dword ptr -28H[ebp],00000003H
                jl      short L166
                jmp     short L167
L165:           mov     eax,dword ptr -28H[ebp]
                inc     dword ptr -28H[ebp]
                jmp     short L164
L166:           imul    eax,dword ptr -24H[ebp],0cH
                mov     edx,dword ptr -38H[ebp]
                add     edx,eax
                mov     eax,dword ptr -28H[ebp]
                shl     eax,02H
                add     eax,edx
                mov     edx,dword ptr -28H[ebp]
                shl     edx,02H
                add     edx,dword ptr -0cH[ebp]
                fld     dword ptr +54H[eax]
                fsub    dword ptr [edx]
                fmul    dword ptr -10H[ebp]
                mov     eax,dword ptr -28H[ebp]
                shl     eax,02H
                add     eax,dword ptr -0cH[ebp]
                fadd    dword ptr [eax]
                mov     eax,dword ptr -28H[ebp]
                shl     eax,02H
                add     eax,dword ptr -8H[ebp]
                fstp    dword ptr [eax]
                jmp     short L165
L167:           mov     eax,dword ptr -8H[ebp]
                add     dword ptr -8H[ebp],0000000cH
L168:           mov     eax,dword ptr -14H[ebp]
                mov     dword ptr -18H[ebp],eax
                mov     eax,dword ptr -1cH[ebp]
                mov     dword ptr -20H[ebp],eax
                mov     eax,dword ptr -0cH[ebp]
                add     dword ptr -0cH[ebp],0000000cH
                jmp     near ptr L159
L169:           mov     edx,dword ptr -30H[ebp]
                add     edx,00000054H
                mov     ebx,dword ptr -8H[ebp]
                sub     ebx,edx
                mov     edx,ebx
                mov     ebx,0000000cH
                mov     eax,edx
                sar     edx,1fH
                idiv    ebx
                mov     edx,dword ptr -30H[ebp]
                mov     dword ptr +50H[edx],eax
                mov     edx,dword ptr -30H[ebp]
                cmp     dword ptr +50H[edx],00000003H
                jge     short L170
                mov     dword ptr -4H[ebp],00000000H
                jmp     short L171
L170:           mov     dword ptr -4H[ebp],00000001H
L171:           mov     eax,dword ptr -4H[ebp]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                ret     
ClipToFrustum_: push    ebx
                push    ecx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000290H
                mov     dword ptr -18H[ebp],eax
                mov     dword ptr -0cH[ebp],edx
                mov     dword ptr -10H[ebp],00000000H
                mov     eax,dword ptr -18H[ebp]
                mov     dword ptr -8H[ebp],eax
                mov     dword ptr -14H[ebp],00000000H
L172:           cmp     dword ptr -14H[ebp],00000003H
                jl      short L174
                jmp     short L176
L173:           mov     eax,dword ptr -14H[ebp]
                inc     dword ptr -14H[ebp]
                jmp     short L172
L174:           imul    ebx,dword ptr -10H[ebp],0000013cH
                lea     eax,-290H[ebp]
                add     ebx,eax
                mov     edx,dword ptr -14H[ebp]
                shl     edx,04H
                mov     eax,offset DGROUP:_frustumplanes
                add     edx,eax
                mov     eax,dword ptr -8H[ebp]
                call    near ptr ClipToPlane_
                test    eax,eax
                jne     short L175
                mov     dword ptr -4H[ebp],00000000H
                jmp     short L177
L175:           imul    eax,dword ptr -10H[ebp],0000013cH
                lea     edx,-290H[ebp]
                add     edx,eax
                mov     dword ptr -8H[ebp],edx
                xor     dword ptr -10H[ebp],00000001H
                jmp     short L173
L176:           mov     ebx,dword ptr -0cH[ebp]
                mov     edx,offset DGROUP:_frustumplanes+30H
                mov     eax,dword ptr -8H[ebp]
                call    near ptr ClipToPlane_
                mov     dword ptr -4H[ebp],eax
L177:           mov     eax,dword ptr -4H[ebp]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     ecx
                pop     ebx
                ret     
computePMN_:    push    ebx
                push    ecx
                push    edx
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,0000002cH
                mov     dword ptr -1cH[ebp],esi
                test    dword ptr +4cH[ebp],7fffffffH
                jne     short L178
                fld     dword ptr +90H[ebp]
                fsub    dword ptr +24H[ebp]
                fdiv    dword ptr +74H[ebp]
                fstp    dword ptr -14H[ebp]
                jmp     short L180
L178:           test    dword ptr +50H[ebp],7fffffffH
                jne     short L179
                fld     dword ptr +94H[ebp]
                fsub    dword ptr +28H[ebp]
                fdiv    dword ptr +78H[ebp]
                fstp    dword ptr -14H[ebp]
                jmp     short L180
L179:           fld     dword ptr +4cH[ebp]
                fdiv    dword ptr +50H[ebp]
                fstp    dword ptr -4H[ebp]
                fld     dword ptr -4H[ebp]
                fmul    dword ptr +50H[ebp]
                fsubr   dword ptr +4cH[ebp]
                fstp    dword ptr -10H[ebp]
                fld     dword ptr -4H[ebp]
                fmul    dword ptr +78H[ebp]
                fsubr   dword ptr +74H[ebp]
                fstp    dword ptr -0cH[ebp]
                fld     dword ptr +94H[ebp]
                fsub    dword ptr +28H[ebp]
                fmul    dword ptr -4H[ebp]
                fld     dword ptr +90H[ebp]
                fsub    dword ptr +24H[ebp]
                fsubrp  st(1),st
                fstp    dword ptr -8H[ebp]
                fld     dword ptr -8H[ebp]
                fdiv    dword ptr -0cH[ebp]
                fstp    dword ptr -14H[ebp]
L180:           test    dword ptr +4cH[ebp],7fffffffH
                je      short L181
                fld     dword ptr +90H[ebp]
                fsub    dword ptr +24H[ebp]
                fld     dword ptr -14H[ebp]
                fmul    dword ptr +74H[ebp]
                fsubp   st(1),st
                fdiv    dword ptr +4cH[ebp]
                fstp    dword ptr -18H[ebp]
                jmp     short L183
L181:           test    dword ptr +50H[ebp],7fffffffH
                je      short L182
                fld     dword ptr +94H[ebp]
                fsub    dword ptr +28H[ebp]
                fld     dword ptr -14H[ebp]
                fmul    dword ptr +78H[ebp]
                fsubp   st(1),st
                fdiv    dword ptr +50H[ebp]
                fstp    dword ptr -18H[ebp]
                jmp     short L183
L182:           mov     eax,offset DGROUP:L249
                push    eax
                call    near ptr printf_
                add     esp,00000004H
                mov     eax,0ffffffffH
                call    near ptr exit_
L183:           mov     eax,dword ptr -18H[ebp]
                mov     dword ptr -2cH[ebp],eax
                mov     eax,dword ptr -14H[ebp]
                mov     dword ptr -28H[ebp],eax
                lea     edi,-24H[ebp]
                lea     esi,-2cH[ebp]
                movsd   
                movsd   
                mov     edi,dword ptr -1cH[ebp]
                lea     esi,-24H[ebp]
                movsd   
                movsd   
                mov     eax,dword ptr -1cH[ebp]
                mov     esp,ebp
                pop     ebp
                pop     edi
                pop     edx
                pop     ecx
                pop     ebx
                ret     0080H
ComputeMagic_:  push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000478H
                mov     dword ptr -10H[ebp],00000080H
                mov     eax,dword ptr +28H[ebp]
                mov     dword ptr -4H[ebp],eax
L184:           cmp     dword ptr -4H[ebp],00000000H
                jne     short L186
                jmp     near ptr L215
L185:           mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +94H[eax]
                mov     dword ptr -4H[ebp],eax
                jmp     short L184
L186:           mov     dword ptr -0cH[ebp],00000000H
                mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +80H[eax]
                mov     dword ptr -208H[ebp],eax
                cmp     dword ptr -208H[ebp],00000000H
                jne     short L187
                mov     eax,offset DGROUP:L250
                push    eax
                call    near ptr printf_
                add     esp,00000004H
                mov     eax,0ffffffffH
                call    near ptr exit_
                jmp     short L188
L187:           mov     eax,dword ptr -208H[ebp]
                fld     dword ptr [eax]
                fadd    dword ptr +1cH[ebp]
                fstp    dword ptr -0ecH[ebp]
                mov     eax,dword ptr -208H[ebp]
                fld     dword ptr +4H[eax]
                fadd    dword ptr +20H[ebp]
                fstp    dword ptr -0e8H[ebp]
                mov     eax,dword ptr -208H[ebp]
                fld     dword ptr +8H[eax]
                fadd    dword ptr +24H[ebp]
                fstp    dword ptr -0e4H[ebp]
                mov     eax,dword ptr -208H[ebp]
                mov     eax,dword ptr +0cH[eax]
                mov     dword ptr -0e0H[ebp],eax
                mov     eax,dword ptr -208H[ebp]
                mov     eax,dword ptr +10H[eax]
                mov     dword ptr -0dcH[ebp],eax
L188:           mov     eax,dword ptr -208H[ebp]
                mov     eax,dword ptr +14H[eax]
                mov     dword ptr -208H[ebp],eax
                cmp     dword ptr -208H[ebp],00000000H
                jne     short L189
                mov     eax,offset DGROUP:L251
                push    eax
                call    near ptr printf_
                add     esp,00000004H
                mov     eax,0ffffffffH
                call    near ptr exit_
                jmp     short L190
L189:           mov     eax,dword ptr -208H[ebp]
                fld     dword ptr [eax]
                fadd    dword ptr +1cH[ebp]
                fstp    dword ptr -0c4H[ebp]
                mov     eax,dword ptr -208H[ebp]
                fld     dword ptr +4H[eax]
                fadd    dword ptr +20H[ebp]
                fstp    dword ptr -0c0H[ebp]
                mov     eax,dword ptr -208H[ebp]
                fld     dword ptr +8H[eax]
                fadd    dword ptr +24H[ebp]
                fstp    dword ptr -0bcH[ebp]
                mov     eax,dword ptr -208H[ebp]
                mov     eax,dword ptr +0cH[eax]
                mov     dword ptr -0b8H[ebp],eax
                mov     eax,dword ptr -208H[ebp]
                mov     eax,dword ptr +10H[eax]
                mov     dword ptr -0b4H[ebp],eax
L190:           mov     eax,dword ptr -208H[ebp]
                mov     eax,dword ptr +14H[eax]
                mov     dword ptr -208H[ebp],eax
                cmp     dword ptr -208H[ebp],00000000H
                jne     short L191
                mov     eax,offset DGROUP:L252
                push    eax
                call    near ptr printf_
                add     esp,00000004H
                mov     eax,0ffffffffH
                call    near ptr exit_
                jmp     short L192
L191:           mov     eax,dword ptr -208H[ebp]
                fld     dword ptr [eax]
                fadd    dword ptr +1cH[ebp]
                fstp    dword ptr -18cH[ebp]
                mov     eax,dword ptr -208H[ebp]
                fld     dword ptr +4H[eax]
                fadd    dword ptr +20H[ebp]
                fstp    dword ptr -188H[ebp]
                mov     eax,dword ptr -208H[ebp]
                fld     dword ptr +8H[eax]
                fadd    dword ptr +24H[ebp]
                fstp    dword ptr -184H[ebp]
                mov     eax,dword ptr -208H[ebp]
                mov     eax,dword ptr +0cH[eax]
                mov     dword ptr -180H[ebp],eax
                mov     eax,dword ptr -208H[ebp]
                mov     eax,dword ptr +10H[eax]
                mov     dword ptr -17cH[ebp],eax
L192:           test    dword ptr -0b8H[ebp],7fffffffH
                jne     short L193
                test    dword ptr -0b4H[ebp],7fffffffH
                je      short L194
L193:           jmp     short L195
L194:           test    dword ptr -180H[ebp],7fffffffH
                je      short L196
L195:           jmp     short L197
L196:           test    dword ptr -17cH[ebp],7fffffffH
                je      near ptr L198
L197:           mov     ecx,0000000aH
                lea     edi,-204H[ebp]
                lea     esi,-0ecH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-0ecH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-0c4H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-258H[ebp]
                call    near ptr vectorsubtract_
                mov     ecx,0000000aH
                lea     edi,-1dcH[ebp]
                lea     esi,-258H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-0ecH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-18cH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-280H[ebp]
                call    near ptr vectorsubtract_
                mov     ecx,0000000aH
                lea     edi,-1b4H[ebp]
                lea     esi,-280H[ebp]
                repe    movsd    
                jmp     near ptr L202
L198:           mov     ecx,0000000aH
                lea     edi,-204H[ebp]
                lea     esi,-0ecH[ebp]
                repe    movsd    
                mov     eax,dword ptr -4H[ebp]
                test    dword ptr +84H[eax],7fffffffH
                jne     short L199
                mov     eax,dword ptr -4H[ebp]
                test    dword ptr +88H[eax],7fffffffH
                je      short L200
L199:           jmp     short L201
L200:           fild    dword ptr -10H[ebp]
                fstp    dword ptr -1dcH[ebp]
                mov     dword ptr -1d8H[ebp],00000000H
                mov     dword ptr -1d4H[ebp],00000000H
                fild    dword ptr -10H[ebp]
                fstp    dword ptr -1d0H[ebp]
                mov     dword ptr -1ccH[ebp],00000000H
                mov     dword ptr -1b4H[ebp],00000000H
                mov     eax,dword ptr -10H[ebp]
                mov     dword ptr -230H[ebp],eax
                neg     dword ptr -230H[ebp]
                fild    dword ptr -230H[ebp]
                fstp    dword ptr -1b0H[ebp]
                mov     dword ptr -1acH[ebp],00000000H
                mov     dword ptr -1a8H[ebp],00000000H
                fild    dword ptr -10H[ebp]
                fstp    dword ptr -1a4H[ebp]
                jmp     near ptr L202
L201:           mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +88H[eax]
                fchs    
                fstp    dword ptr -1dcH[ebp]
                mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +84H[eax]
                mov     dword ptr -1d8H[ebp],eax
                mov     dword ptr -1d4H[ebp],00000000H
                fld     dword ptr -1d8H[ebp]
                fmul    dword ptr -1d8H[ebp]
                fld     dword ptr -1dcH[ebp]
                fmul    dword ptr -1dcH[ebp]
                faddp   st(1),st
                fld     dword ptr -1d4H[ebp]
                fmul    dword ptr -1d4H[ebp]
                faddp   st(1),st
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr sqrt_
                fstp    dword ptr -8H[ebp]
                fild    dword ptr -10H[ebp]
                fdiv    dword ptr -8H[ebp]
                fmul    dword ptr -1dcH[ebp]
                fstp    dword ptr -1dcH[ebp]
                fild    dword ptr -10H[ebp]
                fdiv    dword ptr -8H[ebp]
                fmul    dword ptr -1d8H[ebp]
                fstp    dword ptr -1d8H[ebp]
                fild    dword ptr -10H[ebp]
                fdiv    dword ptr -8H[ebp]
                fmul    dword ptr -1d4H[ebp]
                fstp    dword ptr -1d4H[ebp]
                fild    dword ptr -10H[ebp]
                fstp    dword ptr -1d0H[ebp]
                mov     dword ptr -1ccH[ebp],00000000H
                mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +84H[eax]
                mov     dword ptr -1b4H[ebp],eax
                mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +88H[eax]
                mov     dword ptr -1b0H[ebp],eax
                mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +8cH[eax]
                mov     dword ptr -1acH[ebp],eax
                lea     ebx,-24H[ebp]
                lea     edx,-1b4H[ebp]
                lea     eax,-1dcH[ebp]
                call    near ptr CrossvProduct_
                mov     eax,dword ptr -24H[ebp]
                mov     dword ptr -1b4H[ebp],eax
                mov     eax,dword ptr -20H[ebp]
                mov     dword ptr -1b0H[ebp],eax
                mov     eax,dword ptr -1cH[ebp]
                mov     dword ptr -1acH[ebp],eax
                fld     dword ptr -1b0H[ebp]
                fmul    dword ptr -1b0H[ebp]
                fld     dword ptr -1b4H[ebp]
                fmul    dword ptr -1b4H[ebp]
                faddp   st(1),st
                fld     dword ptr -1acH[ebp]
                fmul    dword ptr -1acH[ebp]
                faddp   st(1),st
                sub     esp,00000008H
                fstp    qword ptr [esp]
                call    near ptr sqrt_
                fstp    dword ptr -8H[ebp]
                fild    dword ptr -10H[ebp]
                fdiv    dword ptr -8H[ebp]
                fmul    dword ptr -1b4H[ebp]
                fstp    dword ptr -1b4H[ebp]
                fild    dword ptr -10H[ebp]
                fdiv    dword ptr -8H[ebp]
                fmul    dword ptr -1b0H[ebp]
                fstp    dword ptr -1b0H[ebp]
                fild    dword ptr -10H[ebp]
                fdiv    dword ptr -8H[ebp]
                fmul    dword ptr -1acH[ebp]
                fstp    dword ptr -1acH[ebp]
                mov     dword ptr -1a8H[ebp],00000000H
                fild    dword ptr -10H[ebp]
                fstp    dword ptr -1a4H[ebp]
L202:           push    00000000H
                push    00000000H
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1b4H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1dcH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-204H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-288H[ebp]
                call    near ptr computePMN_
                lea     edi,-18H[ebp]
                lea     esi,-288H[ebp]
                movsd   
                movsd   
                fld     dword ptr -14H[ebp]
                sub     esp,00000004H
                fstp    dword ptr [esp]
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1b4H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-2b0H[ebp]
                call    near ptr vectorscalar_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-2b0H[ebp]
                repe    movsd    
                fld     dword ptr -18H[ebp]
                sub     esp,00000004H
                fstp    dword ptr [esp]
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1dcH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-2d8H[ebp]
                call    near ptr vectorscalar_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-2d8H[ebp]
                repe    movsd    
                lea     esi,-300H[ebp]
                call    near ptr vectoradd_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-300H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-204H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-328H[ebp]
                call    near ptr vectoradd_
                mov     ecx,0000000aH
                lea     edi,-164H[ebp]
                lea     esi,-328H[ebp]
                repe    movsd    
                push    00000000H
                fild    dword ptr -10H[ebp]
                sub     esp,00000004H
                fstp    dword ptr [esp]
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1b4H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1dcH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-204H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-330H[ebp]
                call    near ptr computePMN_
                lea     edi,-18H[ebp]
                lea     esi,-330H[ebp]
                movsd   
                movsd   
                fld     dword ptr -14H[ebp]
                sub     esp,00000004H
                fstp    dword ptr [esp]
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1b4H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-358H[ebp]
                call    near ptr vectorscalar_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-358H[ebp]
                repe    movsd    
                fld     dword ptr -18H[ebp]
                sub     esp,00000004H
                fstp    dword ptr [esp]
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1dcH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-380H[ebp]
                call    near ptr vectorscalar_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-380H[ebp]
                repe    movsd    
                lea     esi,-3a8H[ebp]
                call    near ptr vectoradd_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-3a8H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-204H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-3d0H[ebp]
                call    near ptr vectoradd_
                mov     ecx,0000000aH
                lea     edi,-13cH[ebp]
                lea     esi,-3d0H[ebp]
                repe    movsd    
                fild    dword ptr -10H[ebp]
                sub     esp,00000004H
                fstp    dword ptr [esp]
                push    00000000H
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1b4H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1dcH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-204H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-3d8H[ebp]
                call    near ptr computePMN_
                lea     edi,-18H[ebp]
                lea     esi,-3d8H[ebp]
                movsd   
                movsd   
                fld     dword ptr -14H[ebp]
                sub     esp,00000004H
                fstp    dword ptr [esp]
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1b4H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-400H[ebp]
                call    near ptr vectorscalar_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-400H[ebp]
                repe    movsd    
                fld     dword ptr -18H[ebp]
                sub     esp,00000004H
                fstp    dword ptr [esp]
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-1dcH[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-428H[ebp]
                call    near ptr vectorscalar_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-428H[ebp]
                repe    movsd    
                lea     esi,-450H[ebp]
                call    near ptr vectoradd_
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-450H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                lea     edi,-230H[ebp]
                lea     esi,-204H[ebp]
                repe    movsd    
                mov     ecx,0000000aH
                sub     esp,00000028H
                mov     edi,esp
                lea     esi,-230H[ebp]
                repe    movsd    
                lea     esi,-478H[ebp]
                call    near ptr vectoradd_
                mov     ecx,0000000aH
                lea     edi,-114H[ebp]
                lea     esi,-478H[ebp]
                repe    movsd    
                mov     eax,dword ptr -164H[ebp]
                mov     dword ptr -4cH[ebp],eax
                mov     eax,dword ptr -160H[ebp]
                mov     dword ptr -48H[ebp],eax
                mov     eax,dword ptr -15cH[ebp]
                mov     dword ptr -44H[ebp],eax
                fldz    
                fcomp   dword ptr -158H[ebp]
                fstsw   ax
                sahf    
                ja      short L203
                mov     eax,dword ptr -158H[ebp]
                mov     dword ptr -40H[ebp],eax
                jmp     short L204
L203:           mov     dword ptr -40H[ebp],00000000H
L204:           fldz    
                fcomp   dword ptr -154H[ebp]
                fstsw   ax
                sahf    
                ja      short L205
                mov     eax,dword ptr -154H[ebp]
                mov     dword ptr -3cH[ebp],eax
                jmp     short L206
L205:           mov     dword ptr -3cH[ebp],00000000H
L206:           mov     ecx,0000000aH
                mov     edi,dword ptr -4H[ebp]
                lea     edi,+4H[edi]
                lea     esi,-4cH[ebp]
                repe    movsd    
                mov     eax,dword ptr -13cH[ebp]
                mov     dword ptr -9cH[ebp],eax
                mov     eax,dword ptr -138H[ebp]
                mov     dword ptr -98H[ebp],eax
                mov     eax,dword ptr -134H[ebp]
                mov     dword ptr -94H[ebp],eax
                fldz    
                fcomp   dword ptr -130H[ebp]
                fstsw   ax
                sahf    
                ja      short L207
                mov     eax,dword ptr -130H[ebp]
                mov     dword ptr -90H[ebp],eax
                jmp     short L208
L207:           mov     dword ptr -90H[ebp],00000000H
L208:           fldz    
                fcomp   dword ptr -12cH[ebp]
                fstsw   ax
                sahf    
                ja      short L209
                mov     eax,dword ptr -12cH[ebp]
                mov     dword ptr -8cH[ebp],eax
                jmp     short L210
L209:           mov     dword ptr -8cH[ebp],00000000H
L210:           mov     ecx,0000000aH
                mov     edi,dword ptr -4H[ebp]
                lea     edi,+2cH[edi]
                lea     esi,-9cH[ebp]
                repe    movsd    
                mov     eax,dword ptr -114H[ebp]
                mov     dword ptr -74H[ebp],eax
                mov     eax,dword ptr -110H[ebp]
                mov     dword ptr -70H[ebp],eax
                mov     eax,dword ptr -10cH[ebp]
                mov     dword ptr -6cH[ebp],eax
                fldz    
                fcomp   dword ptr -108H[ebp]
                fstsw   ax
                sahf    
                ja      short L211
                mov     eax,dword ptr -108H[ebp]
                mov     dword ptr -68H[ebp],eax
                jmp     short L212
L211:           mov     dword ptr -68H[ebp],00000000H
L212:           fldz    
                fcomp   dword ptr -104H[ebp]
                fstsw   ax
                sahf    
                ja      short L213
                mov     eax,dword ptr -104H[ebp]
                mov     dword ptr -64H[ebp],eax
                jmp     short L214
L213:           mov     dword ptr -64H[ebp],00000000H
L214:           mov     ecx,0000000aH
                mov     edi,dword ptr -4H[ebp]
                lea     edi,+54H[edi]
                lea     esi,-74H[ebp]
                repe    movsd    
                jmp     near ptr L185
L215:           mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     0010H
drawFaceList_:  push    ebx
                push    ecx
                push    edx
                push    esi
                push    edi
                push    ebp
                mov     ebp,esp
                sub     esp,00000010H
                mov     dword ptr -0cH[ebp],eax
                mov     eax,dword ptr -0cH[ebp]
                mov     dword ptr -4H[ebp],eax
L216:           cmp     dword ptr -4H[ebp],00000000H
                jne     short L218
                jmp     near ptr L226
L217:           mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +94H[eax]
                mov     dword ptr -4H[ebp],eax
                jmp     short L216
L218:           mov     dword ptr -8H[ebp],00000000H
                mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr +80H[eax]
                mov     dword ptr -10H[ebp],eax
L219:           mov     eax,dword ptr -10H[ebp]
                cmp     dword ptr +14H[eax],00000000H
                jne     short L221
                jmp     short L224
L220:           mov     eax,dword ptr -10H[ebp]
                mov     eax,dword ptr +14H[eax]
                mov     dword ptr -10H[ebp],eax
                jmp     short L219
L221:           imul    edx,dword ptr -8H[ebp],0cH
                mov     eax,dword ptr -10H[ebp]
                fld     dword ptr [eax]
                fstp    dword ptr _coockiespoly+54H[edx]
                imul    edx,dword ptr -8H[ebp],0cH
                mov     eax,dword ptr -10H[ebp]
                fld     dword ptr +8H[eax]
                fstp    dword ptr _coockiespoly+58H[edx]
                imul    edx,dword ptr -8H[ebp],0cH
                mov     eax,dword ptr -10H[ebp]
                fld     dword ptr +4H[eax]
                fstp    dword ptr _coockiespoly+5cH[edx]
                cmp     dword ptr -8H[ebp],00000012H
                jge     short L222
                mov     eax,dword ptr -8H[ebp]
                inc     dword ptr -8H[ebp]
                jmp     short L223
L222:           mov     eax,offset DGROUP:L253
                push    eax
                call    near ptr printf_
                add     esp,00000004H
                mov     eax,0ffffffffH
                call    near ptr exit_
L223:           jmp     short L220
L224:           cmp     dword ptr -8H[ebp],00000003H
                jge     short L225
                mov     eax,offset DGROUP:L254
                push    eax
                call    near ptr printf_
                add     esp,00000004H
                mov     eax,0ffffffffH
                call    near ptr exit_
L225:           mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +4H[eax]
                fstp    dword ptr _coockiespoly+4H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +0cH[eax]
                fstp    dword ptr _coockiespoly+8H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +8H[eax]
                fstp    dword ptr _coockiespoly+0cH
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +2cH[eax]
                fstp    dword ptr _coockiespoly+10H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +34H[eax]
                fstp    dword ptr _coockiespoly+14H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +30H[eax]
                fstp    dword ptr _coockiespoly+18H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +54H[eax]
                fstp    dword ptr _coockiespoly+1cH
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +5cH[eax]
                fstp    dword ptr _coockiespoly+20H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +58H[eax]
                fstp    dword ptr _coockiespoly+24H
                mov     eax,dword ptr -8H[ebp]
                mov     dword ptr _coockiespoly+50H,eax
                mov     eax,dword ptr -4H[ebp]
                mov     eax,dword ptr [eax]
                mov     dword ptr _coockiespoly,eax
                mov     eax,dword ptr _currentbspdepth
                mov     dword ptr _coockiespoly+4cH,eax
                mov     dword ptr _coockiespoly+12cH,00000000H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +84H[eax]
                fchs    
                fstp    dword ptr _coockiespoly+130H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +8cH[eax]
                fchs    
                fstp    dword ptr _coockiespoly+134H
                mov     eax,dword ptr -4H[ebp]
                fld     dword ptr +88H[eax]
                fchs    
                fstp    dword ptr _coockiespoly+138H
                mov     eax,offset DGROUP:_coockiespoly
                call    near ptr addpolygon_
                jmp     near ptr L217
L226:           mov     esp,ebp
                pop     ebp
                pop     edi
                pop     esi
                pop     edx
                pop     ecx
                pop     ebx
                ret     
_TEXT           ENDS

CONST           SEGMENT DWORD PUBLIC USE32 'DATA'
L227            DB      00H,00H,00H,0bfH
L228            DB      00H,00H,00H,00H,00H,00H,0e0H,0bfH
L229            DB      00H,00H,00H,00H,00H,00H,0e0H,0bfH
L230            DB      00H,00H,00H,0bfH
L231            DB      00H,00H,00H,00H,00H,00H,0e0H,0bfH
L232            DB      00H,00H,00H,00H,00H,00H,0e0H,0bfH
L233            DB      00H,00H,00H,00H,00H,00H,0f0H,40H
L234            DB      00H,00H,00H,00H,00H,00H,0f0H,40H
L235            DB      00H,00H,00H,40H
L236            DB      00H,00H,80H,40H
L237            DB      00H,00H,00H,41H
L238            DB      00H,00H,00H,40H
L239            DB      00H,00H,80H,40H
L240            DB      00H,00H,00H,41H
L241            DB      00H,00H,00H,00H,00H,00H,0f0H,3eH
L242            DB      00H,00H,00H,00H,00H,00H,0e0H,3fH
L243            DB      00H,00H,00H,00H,00H,00H,0e0H,0bfH
L244            DB      00H,00H,00H,00H,00H,00H,0e0H,3fH
L245            DB      00H,00H,00H,00H,00H,00H,0e0H,0bfH
L246            DB      7bH,14H,0aeH,47H,0e1H,7aH,84H,0bfH
L247            DB      2dH,43H,1cH,0ebH,0e2H,36H,1aH,3fH
L248            DB      00H,00H,00H,00H,00H,00H,00H,40H
L249            DB      45H,72H,72H,6fH,72H,20H,69H,6eH
                DB      20H,74H,65H,78H,6dH,61H,70H,20H
                DB      63H,6fH,6fH,72H,64H,69H,6eH,61H
                DB      74H,65H,73H,21H,00H
L250            DB      45H,72H,72H,6fH,72H,3aH,50H,6fH
                DB      6cH,79H,67H,6fH,6eH,20H,64H,65H
                DB      74H,65H,63H,74H,65H,64H,20H,77H
                DB      69H,74H,68H,20H,6cH,65H,73H,73H
                DB      20H,74H,68H,65H,6eH,20H,31H,20H
                DB      76H,65H,72H,74H,69H,63H,65H,73H
                DB      00H
L251            DB      45H,72H,72H,6fH,72H,3aH,50H,6fH
                DB      6cH,79H,67H,6fH,6eH,20H,64H,65H
                DB      74H,65H,63H,74H,65H,64H,20H,77H
                DB      69H,74H,68H,20H,6cH,65H,73H,73H
                DB      20H,74H,68H,65H,6eH,20H,32H,20H
                DB      76H,65H,72H,74H,69H,63H,65H,73H
                DB      00H
L252            DB      45H,72H,72H,6fH,72H,3aH,50H,6fH
                DB      6cH,79H,67H,6fH,6eH,20H,64H,65H
                DB      74H,65H,63H,74H,65H,64H,20H,77H
                DB      69H,74H,68H,20H,6cH,65H,73H,73H
                DB      20H,74H,68H,65H,6eH,20H,33H,20H
                DB      76H,65H,72H,74H,69H,63H,65H,73H
                DB      00H
L253            DB      65H,72H,72H,6fH,72H,2eH,20H,70H
                DB      6fH,6cH,79H,67H,6fH,6eH,76H,65H
                DB      72H,74H,69H,63H,65H,73H,20H,6fH
                DB      76H,65H,72H,66H,6cH,6fH,77H,00H
L254            DB      45H,72H,72H,6fH,72H,3aH,50H,6fH
                DB      6cH,79H,67H,6fH,6eH,20H,64H,65H
                DB      74H,65H,63H,74H,65H,64H,20H,77H
                DB      69H,74H,68H,20H,6cH,65H,73H,73H
                DB      20H,74H,68H,65H,6eH,20H,33H,20H
                DB      76H,65H,72H,74H,69H,63H,65H,73H
                DB      00H
CONST           ENDS

CONST2          SEGMENT DWORD PUBLIC USE32 'DATA'
CONST2          ENDS

_DATA           SEGMENT DWORD PUBLIC USE32 'DATA'
                PUBLIC  _INITIAL_DIB_WIDTH 
                PUBLIC  _INITIAL_DIB_HEIGHT 
                PUBLIC  _INITIAL_WINDOW_WIDTH 
                PUBLIC  _INITIAL_WINDOW_HEIGHT 
                PUBLIC  _RUN_LENGTH 
                PUBLIC  _RUN_LENGTHEXP 
                PUBLIC  _speedscale 
                PUBLIC  _playerspeedscale 
                PUBLIC  _mroll 
                PUBLIC  _mpitch 
                PUBLIC  _myaw 
                PUBLIC  _vpn 
                PUBLIC  _xaxis 
                PUBLIC  _yaxis 
                PUBLIC  _zaxis 
                PUBLIC  _maxedge 
_INITIAL_DIB_WIDTH LABEL BYTE
                DB      40H,01H,00H,00H
_INITIAL_DIB_HEIGHT LABEL BYTE
                DB      0c8H,00H,00H,00H
_INITIAL_WINDOW_WIDTH LABEL BYTE
                DB      40H,01H,00H,00H
_INITIAL_WINDOW_HEIGHT LABEL BYTE
                DB      0c8H,00H,00H,00H
_RUN_LENGTH     DB      08H,00H,00H,00H
_RUN_LENGTHEXP  DB      03H,00H,00H,00H
_speedscale     DB      00H,00H,80H,3fH
_playerspeedscale LABEL BYTE
                DB      00H,00H,80H,3fH
_mroll          DB      00H,00H,80H,3fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H,00H,00H,00H,00H
                DB      00H,00H,80H,3fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H,00H,00H,00H,00H
                DB      00H,00H,80H,3fH
_mpitch         DB      00H,00H,80H,3fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H,00H,00H,00H,00H
                DB      00H,00H,80H,3fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H,00H,00H,00H,00H
                DB      00H,00H,80H,3fH
_myaw           DB      00H,00H,80H,3fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H,00H,00H,00H,00H
                DB      00H,00H,80H,3fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H,00H,00H,00H,00H
                DB      00H,00H,80H,3fH
_vpn            DB      00H,00H,80H,3fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H
_xaxis          DB      00H,00H,80H,3fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H
_yaxis          DB      00H,00H,00H,00H,00H,00H,80H,3fH
                DB      00H,00H,00H,00H
_zaxis          DB      00H,00H,00H,00H,00H,00H,00H,00H
                DB      00H,00H,80H,3fH
_maxedge        DB      0ffH,0ffH,0ffH,7fH,00H,00H,00H,00H
                DB      00H,00H,00H,00H,00H,00H,00H,00H
                DB      2 DUP(00H,00H,00H,00H,00H,00H,00H,00H)
                DB      00H,00H,00H,00H
L255            DB      00H,00H
_DATA           ENDS

_BSS            SEGMENT DWORD PUBLIC USE32 'BSS'
                PUBLIC  _newedges 
                PUBLIC  _surfstack 
                PUBLIC  _spans 
                PUBLIC  _frustumplanes 
                PUBLIC  _removeedges 
                PUBLIC  _sixtyfive 
                PUBLIC  _surfs 
                PUBLIC  _coockieModeInfo 
                PUBLIC  _edges 
                PUBLIC  _totalcount 
                PUBLIC  _v0 
                PUBLIC  _v1 
                PUBLIC  _du 
                PUBLIC  _dv 
                PUBLIC  _A 
                PUBLIC  _B 
                PUBLIC  _C 
                PUBLIC  _run 
                PUBLIC  _edgetail 
                PUBLIC  _aa 
                PUBLIC  _bb 
                PUBLIC  _u0 
                PUBLIC  _edgehead 
                PUBLIC  _u1 
                PUBLIC  _fieldofview 
                PUBLIC  _coockieGS 
                PUBLIC  _maxscreenscaleinv 
                PUBLIC  _VBE_Color 
                PUBLIC  _mask2 
                PUBLIC  _fv_lo 
                PUBLIC  _fu_lo 
                PUBLIC  _u 
                PUBLIC  _xscreenscale 
                PUBLIC  _v 
                PUBLIC  _dv_hi 
                PUBLIC  _du_hi 
                PUBLIC  _xcenter 
                PUBLIC  _ycenter 
                PUBLIC  _numobjects 
                PUBLIC  _VBE_Count 
                PUBLIC  _yscreenscale 
                PUBLIC  _dv_lo 
                PUBLIC  _du_lo 
                PUBLIC  _mipmask 
                PUBLIC  _maxscale 
                PUBLIC  _cc 
                PUBLIC  _cinv 
                PUBLIC  _coockiespoly 
                PUBLIC  _mip 
                PUBLIC  _DIBHeight 
                PUBLIC  _VideoOffset 
                PUBLIC  _WindowOffsetY 
                PUBLIC  _WindowOffsetX 
                PUBLIC  _DIBWidth 
                PUBLIC  _vright 
                PUBLIC  _DIBPitch 
                PUBLIC  _vup 
                PUBLIC  _pavailsurf 
                PUBLIC  _startpos 
                PUBLIC  _currentpos 
                PUBLIC  _pavailedge 
                PUBLIC  _yawspeed 
                PUBLIC  _pitch 
                PUBLIC  _currentspeed 
                PUBLIC  _roll 
                PUBLIC  _yaw 
                PUBLIC  _playeryawspeed 
                PUBLIC  _currentbspdepth 
                PUBLIC  _currentcolor 
                PUBLIC  _playeryaw 
                PUBLIC  _playercurrentpos 
                PUBLIC  _playerroll 
                PUBLIC  _playerpitch 
                PUBLIC  _screenbuffer 
                PUBLIC  _FPUCW 
                PUBLIC  _OldFPUCW 
                ORG     00000000H
_newedges       LABEL   BYTE
                ORG     00012000H
_surfstack      LABEL   BYTE
                ORG     00012048H
_spans          LABEL   BYTE
                ORG     00123748H
_frustumplanes  LABEL   BYTE
                ORG     00123788H
_removeedges    LABEL   BYTE
                ORG     00125788H
_sixtyfive      LABEL   BYTE
                ORG     00125790H
_surfs          LABEL   BYTE
                ORG     0015a350H
_coockieModeInfo LABEL   BYTE
                ORG     0015a450H
_edges          LABEL   BYTE
                ORG     00174a30H
_totalcount     LABEL   BYTE
                ORG     00174a34H
_v0             LABEL   BYTE
                ORG     00174a38H
_v1             LABEL   BYTE
                ORG     00174a3cH
_du             LABEL   BYTE
                ORG     00174a40H
_dv             LABEL   BYTE
                ORG     00174a44H
_A              LABEL   BYTE
                ORG     00174a50H
_B              LABEL   BYTE
                ORG     00174a5cH
_C              LABEL   BYTE
                ORG     00174a68H
_run            LABEL   BYTE
                ORG     00174a6cH
_edgetail       LABEL   BYTE
                ORG     00174a90H
_aa             LABEL   BYTE
                ORG     00174a94H
_bb             LABEL   BYTE
                ORG     00174a98H
_u0             LABEL   BYTE
                ORG     00174a9cH
_edgehead       LABEL   BYTE
                ORG     00174ac0H
_u1             LABEL   BYTE
                ORG     00174ac4H
_fieldofview    LABEL   BYTE
                ORG     00174ac8H
_coockieGS      LABEL   BYTE
                ORG     00174accH
_maxscreenscaleinv LABEL   BYTE
                ORG     00174ad0H
_VBE_Color      LABEL   BYTE
                ORG     00174ad4H
_mask2          LABEL   BYTE
                ORG     00174ad8H
_fv_lo          LABEL   BYTE
                ORG     00174adcH
_fu_lo          LABEL   BYTE
                ORG     00174ae0H
_u              LABEL   BYTE
                ORG     00174ae4H
_xscreenscale   LABEL   BYTE
                ORG     00174ae8H
_v              LABEL   BYTE
                ORG     00174aecH
_dv_hi          LABEL   BYTE
                ORG     00174af0H
_du_hi          LABEL   BYTE
                ORG     00174af4H
_xcenter        LABEL   BYTE
                ORG     00174af8H
_ycenter        LABEL   BYTE
                ORG     00174afcH
_numobjects     LABEL   BYTE
                ORG     00174b00H
_VBE_Count      LABEL   BYTE
                ORG     00174b04H
_yscreenscale   LABEL   BYTE
                ORG     00174b08H
_dv_lo          LABEL   BYTE
                ORG     00174b0cH
_du_lo          LABEL   BYTE
                ORG     00174b10H
_mipmask        LABEL   BYTE
                ORG     00174b14H
_maxscale       LABEL   BYTE
                ORG     00174b18H
_cc             LABEL   BYTE
                ORG     00174b1cH
_cinv           LABEL   BYTE
                ORG     00174b20H
_coockiespoly   LABEL   BYTE
                ORG     00174c5cH
_mip            LABEL   BYTE
                ORG     00174c60H
_DIBHeight      LABEL   BYTE
                ORG     00174c64H
_VideoOffset    LABEL   BYTE
                ORG     00174c68H
_WindowOffsetY  LABEL   BYTE
                ORG     00174c6cH
_WindowOffsetX  LABEL   BYTE
                ORG     00174c70H
_DIBWidth       LABEL   BYTE
                ORG     00174c74H
_vright         LABEL   BYTE
                ORG     00174c80H
_DIBPitch       LABEL   BYTE
                ORG     00174c84H
_vup            LABEL   BYTE
                ORG     00174c90H
_pavailsurf     LABEL   BYTE
                ORG     00174c94H
_startpos       LABEL   BYTE
                ORG     00174ca0H
_currentpos     LABEL   BYTE
                ORG     00174cacH
_pavailedge     LABEL   BYTE
                ORG     00174cb0H
_yawspeed       LABEL   BYTE
                ORG     00174cb4H
_pitch          LABEL   BYTE
                ORG     00174cb8H
_currentspeed   LABEL   BYTE
                ORG     00174cbcH
_roll           LABEL   BYTE
                ORG     00174cc0H
_yaw            LABEL   BYTE
                ORG     00174cc4H
_playeryawspeed LABEL   BYTE
                ORG     00174cc8H
_currentbspdepth LABEL   BYTE
                ORG     00174cccH
_currentcolor   LABEL   BYTE
                ORG     00174cd0H
_playeryaw      LABEL   BYTE
                ORG     00174cd4H
_playercurrentpos LABEL   BYTE
                ORG     00174ce0H
_playerroll     LABEL   BYTE
                ORG     00174ce4H
_playerpitch    LABEL   BYTE
                ORG     00174ce8H
_screenbuffer   LABEL   BYTE
                ORG     00174cecH
_FPUCW          LABEL   BYTE
                ORG     00174ceeH
_OldFPUCW       LABEL   BYTE
                ORG     00174cf0H
_BSS            ENDS

$$SYMBOLS       SEGMENT BYTE USE16 'DEBSYM'
                DB      11H,12H
                DP      DGROUP:_newedges
                DB      30H,6eH,65H,77H,65H,64H,67H,65H
                DB      73H,12H,12H
                DP      DGROUP:_surfstack
                DB      2cH,73H,75H,72H,66H,73H,74H,61H
                DB      63H,6bH,0eH,12H
                DP      DGROUP:_spans
                DB      33H,73H,70H,61H,6eH,73H,16H,12H
                DP      DGROUP:_frustumplanes
                DB      36H,66H,72H,75H,73H,74H,75H,6dH
                DB      70H,6cH,61H,6eH,65H,73H,14H,12H
                DP      DGROUP:_removeedges
                DB      38H,72H,65H,6dH,6fH,76H,65H,65H
                DB      64H,67H,65H,73H,12H,12H
                DP      DGROUP:_sixtyfive
                DB      39H,73H,69H,78H,74H,79H,66H,69H
                DB      76H,65H,0eH,12H
                DP      DGROUP:_surfs
                DB      3aH,73H,75H,72H,66H,73H,18H,12H
                DP      DGROUP:_coockieModeInfo
                DB      3eH,63H,6fH,6fH,63H,6bH,69H,65H
                DB      4dH,6fH,64H,65H,49H,6eH,66H,6fH
                DB      0eH,12H
                DP      DGROUP:_edges
                DB      3fH,65H,64H,67H,65H,73H,13H,12H
                DP      DGROUP:_totalcount
                DB      09H,74H,6fH,74H,61H,6cH,63H,6fH
                DB      75H,6eH,74H,0bH,12H
                DP      DGROUP:_v0
                DB      15H,76H,30H,0bH,12H
                DP      DGROUP:_v1
                DB      15H,76H,31H,0bH,12H
                DP      DGROUP:_du
                DB      15H,64H,75H,0bH,12H
                DP      DGROUP:_dv
                DB      15H,64H,76H,0aH,12H
                DP      DGROUP:_A
                DB      28H,41H,0aH,12H
                DP      DGROUP:_B
                DB      28H,42H,0aH,12H
                DP      DGROUP:_C
                DB      28H,43H,0cH,12H
                DP      DGROUP:_run
                DB      09H,72H,75H,6eH,11H,12H
                DP      DGROUP:_edgetail
                DB      2fH,65H,64H,67H,65H,74H,61H,69H
                DB      6cH,10H,12H
                DP      DGROUP:_maxedge
                DB      2fH,6dH,61H,78H,65H,64H,67H,65H
                DB      0bH,12H
                DP      DGROUP:_aa
                DB      23H,61H,61H,0bH,12H
                DP      DGROUP:_bb
                DB      23H,62H,62H,0bH,12H
                DP      DGROUP:_u0
                DB      15H,75H,30H,11H,12H
                DP      DGROUP:_edgehead
                DB      2fH,65H,64H,67H,65H,68H,65H,61H
                DB      64H,0bH,12H
                DP      DGROUP:_u1
                DB      15H,75H,31H,14H,12H
                DP      DGROUP:_fieldofview
                DB      23H,66H,69H,65H,6cH,64H,6fH,66H
                DB      76H,69H,65H,77H,12H,12H
                DP      DGROUP:_coockieGS
                DB      09H,63H,6fH,6fH,63H,6bH,69H,65H
                DB      47H,53H,1aH,12H
                DP      DGROUP:_maxscreenscaleinv
                DB      23H,6dH,61H,78H,73H,63H,72H,65H
                DB      65H,6eH,73H,63H,61H,6cH,65H,69H
                DB      6eH,76H,12H,12H
                DP      DGROUP:_VBE_Color
                DB      09H,56H,42H,45H,5fH,43H,6fH,6cH
                DB      6fH,72H,0eH,12H
                DP      DGROUP:_mask2
                DB      09H,6dH,61H,73H,6bH,32H,0eH,12H
                DP      DGROUP:_fv_lo
                DB      15H,66H,76H,5fH,6cH,6fH,0eH,12H
                DP      DGROUP:_fu_lo
                DB      15H,66H,75H,5fH,6cH,6fH,0aH,12H
                DP      DGROUP:_u
                DB      09H,75H,15H,12H
                DP      DGROUP:_xscreenscale
                DB      23H,78H,73H,63H,72H,65H,65H,6eH
                DB      73H,63H,61H,6cH,65H,0aH,12H
                DP      DGROUP:_v
                DB      09H,76H,0eH,12H
                DP      DGROUP:_dv_hi
                DB      09H,64H,76H,5fH,68H,69H,0eH,12H
                DP      DGROUP:_du_hi
                DB      09H,64H,75H,5fH,68H,69H,10H,12H
                DP      DGROUP:_xcenter
                DB      23H,78H,63H,65H,6eH,74H,65H,72H
                DB      10H,12H
                DP      DGROUP:_ycenter
                DB      23H,79H,63H,65H,6eH,74H,65H,72H
                DB      13H,12H
                DP      DGROUP:_numobjects
                DB      09H,6eH,75H,6dH,6fH,62H,6aH,65H
                DB      63H,74H,73H,12H,12H
                DP      DGROUP:_VBE_Count
                DB      09H,56H,42H,45H,5fH,43H,6fH,75H
                DB      6eH,74H,15H,12H
                DP      DGROUP:_yscreenscale
                DB      23H,79H,73H,63H,72H,65H,65H,6eH
                DB      73H,63H,61H,6cH,65H,0eH,12H
                DP      DGROUP:_dv_lo
                DB      15H,64H,76H,5fH,6cH,6fH,0eH,12H
                DP      DGROUP:_du_lo
                DB      15H,64H,75H,5fH,6cH,6fH,10H,12H
                DP      DGROUP:_mipmask
                DB      09H,6dH,69H,70H,6dH,61H,73H,6bH
                DB      11H,12H
                DP      DGROUP:_maxscale
                DB      23H,6dH,61H,78H,73H,63H,61H,6cH
                DB      65H,0bH,12H
                DP      DGROUP:_cc
                DB      23H,63H,63H,0dH,12H
                DP      DGROUP:_cinv
                DB      23H,63H,69H,6eH,76H,15H,12H
                DP      DGROUP:_coockiespoly
                DB      42H,63H,6fH,6fH,63H,6bH,69H,65H
                DB      73H,70H,6fH,6cH,79H,0cH,12H
                DP      DGROUP:_vpn
                DB      28H,76H,70H,6eH,0cH,12H
                DP      DGROUP:_mip
                DB      23H,6dH,69H,70H,13H,12H
                DP      DGROUP:_RUN_LENGTH
                DB      09H,52H,55H,4eH,5fH,4cH,45H,4eH
                DB      47H,54H,48H,12H,12H
                DP      DGROUP:_DIBHeight
                DB      09H,44H,49H,42H,48H,65H,69H,67H
                DB      68H,74H,14H,12H
                DP      DGROUP:_VideoOffset
                DB      43H,56H,69H,64H,65H,6fH,4fH,66H
                DB      66H,73H,65H,74H,16H,12H
                DP      DGROUP:_WindowOffsetY
                DB      09H,57H,69H,6eH,64H,6fH,77H,4fH
                DB      66H,66H,73H,65H,74H,59H,16H,12H
                DP      DGROUP:_WindowOffsetX
                DB      09H,57H,69H,6eH,64H,6fH,77H,4fH
                DB      66H,66H,73H,65H,74H,58H,11H,12H
                DP      DGROUP:_DIBWidth
                DB      09H,44H,49H,42H,57H,69H,64H,74H
                DB      68H,0fH,12H
                DP      DGROUP:_vright
                DB      28H,76H,72H,69H,67H,68H,74H,11H
                DB      12H
                DP      DGROUP:_DIBPitch
                DB      09H,44H,49H,42H,50H,69H,74H,63H
                DB      68H,0cH,12H
                DP      DGROUP:_vup
                DB      28H,76H,75H,70H,16H,12H
                DP      DGROUP:_RUN_LENGTHEXP
                DB      09H,52H,55H,4eH,5fH,4cH,45H,4eH
                DB      47H,54H,48H,45H,58H,50H,13H,12H
                DP      DGROUP:_pavailsurf
                DB      2dH,70H,61H,76H,61H,69H,6cH,73H
                DB      75H,72H,66H,11H,12H
                DP      DGROUP:_startpos
                DB      28H,73H,74H,61H,72H,74H,70H,6fH
                DB      73H,0dH,12H
                DP      DGROUP:_myaw
                DB      45H,6dH,79H,61H,77H,13H,12H
                DP      DGROUP:_currentpos
                DB      28H,63H,75H,72H,72H,65H,6eH,74H
                DB      70H,6fH,73H,13H,12H
                DP      DGROUP:_pavailedge
                DB      37H,70H,61H,76H,61H,69H,6cH,65H
                DB      64H,67H,65H,11H,12H
                DP      DGROUP:_yawspeed
                DB      23H,79H,61H,77H,73H,70H,65H,65H
                DB      64H,0fH,12H
                DP      DGROUP:_mpitch
                DB      47H,6dH,70H,69H,74H,63H,68H,0eH
                DB      12H
                DP      DGROUP:_yaxis
                DB      28H,79H,61H,78H,69H,73H,0eH,12H
                DP      DGROUP:_pitch
                DB      23H,70H,69H,74H,63H,68H,0eH,12H
                DP      DGROUP:_xaxis
                DB      28H,78H,61H,78H,69H,73H,13H,12H
                DP      DGROUP:_speedscale
                DB      23H,73H,70H,65H,65H,64H,73H,63H
                DB      61H,6cH,65H,15H,12H
                DP      DGROUP:_currentspeed
                DB      23H,63H,75H,72H,72H,65H,6eH,74H
                DB      73H,70H,65H,65H,64H,0dH,12H
                DP      DGROUP:_roll
                DB      23H,72H,6fH,6cH,6cH,0cH,12H
                DP      DGROUP:_yaw
                DB      23H,79H,61H,77H,17H,12H
                DP      DGROUP:_playeryawspeed
                DB      23H,70H,6cH,61H,79H,65H,72H,79H
                DB      61H,77H,73H,70H,65H,65H,64H,0eH
                DB      12H
                DP      DGROUP:_zaxis
                DB      28H,7aH,61H,78H,69H,73H,18H,12H
                DP      DGROUP:_currentbspdepth
                DB      09H,63H,75H,72H,72H,65H,6eH,74H
                DB      62H,73H,70H,64H,65H,70H,74H,68H
                DB      15H,12H
                DP      DGROUP:_currentcolor
                DB      09H,63H,75H,72H,72H,65H,6eH,74H
                DB      63H,6fH,6cH,6fH,72H,12H,12H
                DP      DGROUP:_playeryaw
                DB      23H,70H,6cH,61H,79H,65H,72H,79H
                DB      61H,77H,19H,12H
                DP      DGROUP:_playercurrentpos
                DB      28H,70H,6cH,61H,79H,65H,72H,63H
                DB      75H,72H,72H,65H,6eH,74H,70H,6fH
                DB      73H,13H,12H
                DP      DGROUP:_playerroll
                DB      23H,70H,6cH,61H,79H,65H,72H,72H
                DB      6fH,6cH,6cH,0eH,12H
                DP      DGROUP:_mroll
                DB      49H,6dH,72H,6fH,6cH,6cH,14H,12H
                DP      DGROUP:_playerpitch
                DB      23H,70H,6cH,61H,79H,65H,72H,70H
                DB      69H,74H,63H,68H,19H,12H
                DP      DGROUP:_playerspeedscale
                DB      23H,70H,6cH,61H,79H,65H,72H,73H
                DB      70H,65H,65H,64H,73H,63H,61H,6cH
                DB      65H,1dH,12H
                DP      DGROUP:_INITIAL_WINDOW_WIDTH
                DB      09H,49H,4eH,49H,54H,49H,41H,4cH
                DB      5fH,57H,49H,4eH,44H,4fH,57H,5fH
                DB      57H,49H,44H,54H,48H,1eH,12H
                DP      DGROUP:_INITIAL_WINDOW_HEIGHT
                DB      09H,49H,4eH,49H,54H,49H,41H,4cH
                DB      5fH,57H,49H,4eH,44H,4fH,57H,5fH
                DB      48H,45H,49H,47H,48H,54H,1bH,12H
                DP      DGROUP:_INITIAL_DIB_HEIGHT
                DB      09H,49H,4eH,49H,54H,49H,41H,4cH
                DB      5fH,44H,49H,42H,5fH,48H,45H,49H
                DB      47H,48H,54H,15H,12H
                DP      DGROUP:_screenbuffer
                DB      43H,73H,63H,72H,65H,65H,6eH,62H
                DB      75H,66H,66H,65H,72H,1aH,12H
                DP      DGROUP:_INITIAL_DIB_WIDTH
                DB      09H,49H,4eH,49H,54H,49H,41H,4cH
                DB      5fH,44H,49H,42H,5fH,57H,49H,44H
                DB      54H,48H,0eH,12H
                DP      DGROUP:_FPUCW
                DB      07H,46H,50H,55H,43H,57H,11H,12H
                DP      DGROUP:_OldFPUCW
                DB      07H,4fH,6cH,64H,46H,50H,55H,43H
                DB      57H,08H,32H
                DP      coockie_getLinearSelector_
                DB      30H,24H,00H,00H,00H,00H,34H,00H
                DB      00H,00H,00H,00H,0eH,09H,18H,00H
                DB      00H,00H,4bH,48H,01H,30H,1cH,63H
                DB      6fH,6fH,63H,6bH,69H,65H,5fH,67H
                DB      65H,74H,4cH,69H,6eH,65H,61H,72H
                DB      53H,65H,6cH,65H,63H,74H,6fH,72H
                DB      07H,11H,10H,0f8H,4aH,6dH,69H,10H
                DB      11H,21H
                DP      DGROUP:L255
                DB      1eH,6cH,69H,6eH,53H,65H,6cH,28H
                DB      24H,34H,00H,00H,00H,0e6H,04H,00H
                DB      00H,00H,00H,0dH,08H,14H,00H,00H
                DB      00H,53H,00H,02H,30H,1cH,30H,1fH
                DB      41H,64H,64H,50H,6fH,6cH,79H,67H
                DB      6fH,6eH,45H,64H,67H,65H,73H,0aH
                DB      11H,10H,0c0H,4cH,70H,6cH,61H,6eH
                DB      65H,0fH,11H,10H,0bcH,52H,73H,63H
                DB      72H,65H,65H,6eH,70H,6fH,6cH,79H
                DB      0cH,11H,10H,0acH,39H,64H,69H,73H
                DB      74H,69H,6eH,76H,0bH,11H,10H,9cH
                DB      39H,64H,65H,6cH,74H,61H,78H,0bH
                DB      11H,10H,0a4H,39H,64H,65H,6cH,74H
                DB      61H,79H,0aH,11H,10H,0b4H,39H,73H
                DB      6cH,6fH,70H,65H,06H,11H,10H,0c4H
                DB      09H,69H,0dH,11H,10H,0c8H,09H,6eH
                DB      65H,78H,74H,76H,65H,72H,74H,0dH
                DB      11H,10H,0ccH,09H,6eH,75H,6dH,76H
                DB      65H,72H,74H,73H,0dH,11H,10H,0d0H
                DB      09H,43H,65H,69H,6cH,74H,6fH,70H
                DB      79H,10H,11H,10H,0d4H,09H,43H,65H
                DB      69H,6cH,62H,6fH,74H,74H,6fH,6dH
                DB      79H,0aH,11H,10H,0d8H,37H,70H,65H
                DB      64H,67H,65H,06H,11H,10H,0dcH,09H
                DB      61H,06H,11H,10H,0e0H,09H,62H,0eH
                DB      11H,10H,0e4H,23H,74H,65H,6dH,70H
                DB      5fH,69H,6eH,76H,7aH,0fH,11H,10H
                DB      0e8H,23H,74H,65H,6dH,70H,5fH,6eH
                DB      69H,6eH,76H,7aH,0fH,11H,10H,0ecH
                DB      23H,52H,65H,61H,6cH,68H,65H,69H
                DB      67H,68H,74H,0eH,11H,10H,0f0H,23H
                DB      52H,65H,61H,6cH,77H,69H,64H,74H
                DB      68H,0dH,11H,10H,0f4H,23H,59H,50H
                DB      72H,65H,73H,74H,65H,70H,0dH,11H
                DB      10H,0f8H,09H,54H,6fH,70H,49H,6eH
                DB      64H,65H,78H,10H,11H,10H,0fcH,09H
                DB      42H,6fH,74H,74H,6fH,6dH,49H,6eH
                DB      64H,65H,78H,22H,24H,1aH,05H,00H
                DB      00H,0e8H,06H,00H,00H,00H,00H,0eH
                DB      09H,18H,00H,00H,00H,54H,00H,00H
                DB      56H,42H,45H,5fH,44H,72H,61H,77H
                DB      53H,70H,61H,6eH,73H,0aH,11H,10H
                DB      0dcH,55H,70H,73H,70H,61H,6eH,0aH
                DB      11H,10H,0e0H,09H,63H,6fH,75H,6eH
                DB      74H,09H,11H,10H,0e4H,23H,41H,31H
                DB      36H,78H,09H,11H,10H,0e8H,23H,42H
                DB      31H,36H,78H,09H,11H,10H,0ecH,23H
                DB      43H,31H,36H,78H,07H,11H,10H,0f0H
                DB      23H,78H,30H,07H,11H,10H,0f4H,23H
                DB      79H,30H,07H,11H,10H,0f8H,09H,78H
                DB      78H,07H,11H,10H,0fcH,09H,79H,79H
                DB      22H,24H,02H,0cH,00H,00H,0c5H,06H
                DB      00H,00H,00H,00H,0eH,09H,18H,00H
                DB      00H,00H,54H,00H,00H,56H,47H,41H
                DB      5fH,44H,72H,61H,77H,53H,70H,61H
                DB      6eH,73H,0aH,11H,10H,0dcH,55H,70H
                DB      73H,70H,61H,6eH,0aH,11H,10H,0e0H
                DB      09H,63H,6fH,75H,6eH,74H,09H,11H
                DB      10H,0e4H,23H,41H,31H,36H,78H,09H
                DB      11H,10H,0e8H,23H,42H,31H,36H,78H
                DB      09H,11H,10H,0ecH,23H,43H,31H,36H
                DB      78H,07H,11H,10H,0f0H,23H,78H,30H
                DB      07H,11H,10H,0f4H,23H,79H,30H,07H
                DB      11H,10H,0f8H,09H,78H,78H,07H,11H
                DB      10H,0fcH,09H,79H,79H,1eH,24H,0c7H
                DB      12H,00H,00H,0a8H,06H,00H,00H,00H
                DB      00H,0eH,09H,18H,00H,00H,00H,54H
                DB      00H,00H,53H,63H,61H,6eH,45H,64H
                DB      67H,65H,73H,06H,11H,10H,0c8H,09H
                DB      78H,06H,11H,10H,0d0H,09H,79H,07H
                DB      11H,10H,0ccH,23H,66H,78H,07H,11H
                DB      10H,0ecH,23H,66H,79H,0aH,11H,10H
                DB      0d4H,23H,74H,69H,6eH,76H,7aH,0bH
                DB      11H,10H,0d8H,23H,74H,69H,6eH,76H
                DB      7aH,32H,0aH,11H,10H,0dcH,37H,70H
                DB      65H,64H,67H,65H,0bH,11H,10H,0e0H
                DB      37H,70H,65H,64H,67H,65H,32H,0aH
                DB      11H,10H,0e4H,37H,70H,74H,65H,6dH
                DB      70H,12H,11H,10H,0e8H,37H,6dH,61H
                DB      74H,63H,68H,69H,6eH,67H,5fH,65H
                DB      64H,67H,65H,0eH,11H,10H,0a4H,2fH
                DB      6cH,65H,66H,74H,5fH,65H,64H,67H
                DB      65H,0aH,11H,10H,0f0H,55H,70H,73H
                DB      70H,61H,6eH,0aH,11H,10H,0f4H,2dH
                DB      70H,73H,75H,72H,66H,0bH,11H,10H
                DB      0f8H,2dH,70H,73H,75H,72H,66H,32H
                DB      10H,11H,10H,0fcH,23H,73H,6cH,69H
                DB      63H,65H,5fH,77H,69H,64H,74H,68H
                DB      23H,24H,6fH,19H,00H,00H,53H,00H
                DB      00H,00H,00H,00H,0eH,09H,18H,00H
                DB      00H,00H,54H,00H,00H,43H,6cH,65H
                DB      61H,72H,45H,64H,67H,65H,4cH,69H
                DB      73H,74H,73H,06H,11H,10H,0fcH,09H
                DB      69H,21H,24H,0c2H,19H,00H,00H,93H
                DB      02H,00H,00H,00H,00H,0eH,09H,18H
                DB      00H,00H,00H,57H,00H,01H,30H,1cH
                DB      61H,64H,64H,70H,6fH,6cH,79H,67H
                DB      6fH,6eH,0aH,11H,10H,0fcH,56H,70H
                DB      70H,6fH,6cH,79H,10H,11H,11H,8cH
                DB      0feH,51H,73H,63H,72H,65H,65H,6eH
                DB      70H,6fH,6cH,79H,0cH,11H,11H,50H
                DB      0fdH,42H,74H,70H,6fH,6cH,79H,31H
                DB      0cH,11H,11H,0d8H,0faH,42H,74H,70H
                DB      6fH,6cH,79H,32H,0cH,11H,11H,14H
                DB      0fcH,42H,74H,70H,6fH,6cH,79H,33H
                DB      0aH,11H,10H,0e0H,35H,70H,6cH,61H
                DB      6eH,65H,0cH,11H,10H,0f0H,28H,74H
                DB      6eH,6fH,72H,6dH,61H,6cH,06H,11H
                DB      10H,0b8H,5dH,50H,06H,11H,10H,90H
                DB      5dH,4dH,07H,11H,11H,68H,0ffH,5dH
                DB      4eH,1dH,24H,55H,1cH,00H,00H,0cfH
                DB      00H,00H,00H,00H,00H,0eH,09H,18H
                DB      00H,00H,00H,5eH,30H,1cH,00H,49H
                DB      6eH,69H,74H,50H,6fH,73H,1eH,24H
                DB      24H,1dH,00H,00H,6eH,01H,00H,00H
                DB      00H,00H,0eH,09H,18H,00H,00H,00H
                DB      5eH,30H,1cH,00H,49H,6eH,69H,74H
                DB      44H,72H,61H,77H,20H,24H,92H,1eH
                DB      00H,00H,3cH,01H,00H,00H,00H,00H
                DB      0eH,09H,18H,00H,00H,00H,5eH,30H
                DB      1cH,00H,55H,70H,64H,61H,74H,65H
                DB      44H,72H,61H,77H,27H,24H,0ceH,1fH
                DB      00H,00H,0afH,00H,00H,00H,00H,00H
                DB      0dH,08H,14H,00H,00H,00H,5fH,00H
                DB      02H,30H,1cH,30H,1fH,50H,72H,6fH
                DB      6aH,65H,63H,74H,50H,6fH,6cH,79H
                DB      67H,6fH,6eH,0aH,11H,10H,0f0H,56H
                DB      70H,70H,6fH,6cH,79H,0cH,11H,10H
                DB      0f4H,52H,70H,70H,6fH,6cH,79H,32H
                DB      44H,06H,11H,10H,0f8H,09H,69H,0bH
                DB      11H,10H,0fcH,23H,7aH,72H,65H,63H
                DB      69H,70H,29H,24H,7dH,20H,00H,00H
                DB      78H,00H,00H,00H,00H,00H,0dH,08H
                DB      14H,00H,00H,00H,61H,00H,02H,30H
                DB      1cH,30H,1fH,42H,61H,63H,6bH,52H
                DB      6fH,74H,61H,74H,65H,56H,65H,63H
                DB      74H,6fH,72H,08H,11H,10H,0f4H,60H
                DB      70H,69H,6eH,09H,11H,10H,0f8H,60H
                DB      70H,6fH,75H,74H,06H,11H,10H,0fcH
                DB      09H,69H,27H,24H,0f5H,20H,00H,00H
                DB      8dH,00H,00H,00H,00H,00H,0dH,08H
                DB      14H,00H,00H,00H,61H,00H,02H,30H
                DB      1cH,30H,1fH,54H,72H,61H,6eH,73H
                DB      66H,6fH,72H,6dH,50H,6fH,69H,6eH
                DB      74H,08H,11H,10H,0f4H,60H,70H,69H
                DB      6eH,09H,11H,10H,0fcH,60H,70H,6fH
                DB      75H,74H,06H,11H,10H,0f8H,09H,69H
                DB      0aH,11H,10H,0e8H,28H,74H,76H,65H
                DB      72H,74H,28H,24H,82H,21H,00H,00H
                DB      8dH,00H,00H,00H,00H,00H,0dH,08H
                DB      14H,00H,00H,00H,63H,00H,02H,30H
                DB      1cH,30H,1fH,54H,72H,61H,6eH,73H
                DB      66H,6fH,72H,6dH,76H,50H,6fH,69H
                DB      6eH,74H,08H,11H,10H,0f4H,60H,70H
                DB      69H,6eH,09H,11H,10H,0fcH,62H,70H
                DB      6fH,75H,74H,06H,11H,10H,0f8H,09H
                DB      69H,0aH,11H,10H,0e8H,28H,74H,76H
                DB      65H,72H,74H,29H,24H,0fH,22H,00H
                DB      00H,62H,00H,00H,00H,00H,00H,0dH
                DB      08H,14H,00H,00H,00H,64H,00H,02H
                DB      30H,1cH,30H,1fH,54H,72H,61H,6eH
                DB      73H,66H,6fH,72H,6dH,50H,6fH,6cH
                DB      79H,67H,6fH,6eH,0cH,11H,10H,0f4H
                DB      56H,70H,69H,6eH,70H,6fH,6cH,79H
                DB      0dH,11H,10H,0f8H,56H,70H,6fH,75H
                DB      74H,70H,6fH,6cH,79H,06H,11H,10H
                DB      0fcH,09H,69H,29H,24H,71H,22H,00H
                DB      00H,82H,00H,00H,00H,00H,00H,0dH
                DB      0aH,14H,00H,00H,00H,65H,30H,1cH
                DB      02H,30H,1cH,30H,1fH,50H,6fH,6cH
                DB      79H,46H,61H,63H,65H,73H,56H,69H
                DB      65H,77H,65H,72H,0aH,11H,10H,0f0H
                DB      56H,70H,70H,6fH,6cH,79H,0bH,11H
                DB      10H,0f8H,4cH,70H,70H,6cH,61H,6eH
                DB      65H,0cH,11H,10H,18H,28H,70H,6fH
                DB      73H,69H,74H,69H,65H,06H,11H,10H
                DB      0f4H,09H,69H,0cH,11H,10H,0e4H,28H
                DB      76H,69H,65H,77H,76H,65H,63H,2fH
                DB      24H,0f3H,22H,00H,00H,44H,00H,00H
                DB      00H,00H,00H,0dH,08H,14H,00H,00H
                DB      00H,66H,00H,02H,30H,1cH,30H,1fH
                DB      53H,65H,74H,57H,6fH,72H,6cH,64H
                DB      73H,70H,61H,63H,65H,43H,6cH,69H
                DB      70H,50H,6cH,61H,6eH,65H,0bH,11H
                DB      10H,0f8H,60H,6eH,6fH,72H,6dH,61H
                DB      6cH,0aH,11H,10H,0fcH,4cH,70H,6cH
                DB      61H,6eH,65H,21H,24H,37H,23H,00H
                DB      00H,19H,01H,00H,00H,00H,00H,0eH
                DB      09H,18H,00H,00H,00H,54H,00H,00H
                DB      53H,65H,74H,55H,70H,46H,72H,75H
                DB      73H,74H,75H,6dH,0aH,11H,10H,0f4H
                DB      23H,61H,6eH,67H,6cH,65H,06H,11H
                DB      10H,0fcH,23H,73H,06H,11H,10H,0f8H
                DB      23H,63H,0bH,11H,10H,0e8H,28H,6eH
                DB      6fH,72H,6dH,61H,6cH,27H,24H,50H
                DB      24H,00H,00H,0a9H,01H,00H,00H,00H
                DB      00H,0cH,07H,10H,00H,00H,00H,67H
                DB      30H,1cH,03H,30H,1cH,30H,1fH,30H
                DB      1dH,43H,6cH,69H,70H,54H,6fH,50H
                DB      6cH,61H,6eH,65H,08H,11H,10H,0c8H
                DB      56H,70H,69H,6eH,0bH,11H,10H,0ccH
                DB      4cH,70H,70H,6cH,61H,6eH,65H,09H
                DB      11H,10H,0d0H,56H,70H,6fH,75H,74H
                DB      06H,11H,10H,0d4H,09H,69H,06H,11H
                DB      10H,0d8H,09H,6aH,0dH,11H,10H,0dcH
                DB      09H,6eH,65H,78H,74H,76H,65H,72H
                DB      74H,0aH,11H,10H,0e0H,09H,63H,75H
                DB      72H,69H,6eH,0bH,11H,10H,0e4H,09H
                DB      6eH,65H,78H,74H,69H,6eH,0bH,11H
                DB      10H,0e8H,23H,63H,75H,72H,64H,6fH
                DB      74H,0cH,11H,10H,0ecH,23H,6eH,65H
                DB      78H,74H,64H,6fH,74H,0aH,11H,10H
                DB      0f0H,23H,73H,63H,61H,6cH,65H,0cH
                DB      11H,10H,0f4H,60H,70H,69H,6eH,76H
                DB      65H,72H,74H,0dH,11H,10H,0f8H,60H
                DB      70H,6fH,75H,74H,76H,65H,72H,74H
                DB      27H,24H,0f9H,25H,00H,00H,9eH,00H
                DB      00H,00H,00H,00H,0dH,08H,14H,00H
                DB      00H,00H,68H,30H,1cH,02H,30H,1cH
                DB      30H,1fH,43H,6cH,69H,70H,54H,6fH
                DB      46H,72H,75H,73H,74H,75H,6dH,08H
                DB      11H,10H,0e8H,56H,70H,69H,6eH,09H
                DB      11H,10H,0f4H,56H,70H,6fH,75H,74H
                DB      06H,11H,10H,0ecH,09H,69H,0cH,11H
                DB      10H,0f0H,09H,63H,75H,72H,70H,6fH
                DB      6cH,79H,0bH,11H,11H,70H,0fdH,69H
                DB      74H,70H,6fH,6cH,79H,0aH,11H,10H
                DB      0f8H,56H,70H,70H,6fH,6cH,79H,20H
                DB      24H,97H,26H,00H,00H,0dH,01H,00H
                DB      00H,00H,00H,0dH,0aH,14H,00H,00H
                DB      00H,6cH,50H,20H,00H,63H,6fH,6dH
                DB      70H,75H,74H,65H,50H,4dH,4eH,07H
                DB      11H,10H,18H,5dH,53H,30H,07H,11H
                DB      10H,40H,5dH,53H,31H,07H,11H,10H
                DB      68H,5dH,53H,32H,08H,11H,11H,90H
                DB      00H,23H,77H,75H,08H,11H,11H,94H
                DB      00H,23H,77H,76H,08H,11H,10H,0d4H
                DB      6bH,6fH,75H,74H,06H,11H,10H,0e8H
                DB      23H,78H,06H,11H,10H,0ecH,23H,79H
                DB      07H,11H,10H,0f0H,23H,68H,30H,07H
                DB      11H,10H,0f4H,23H,68H,31H,07H,11H
                DB      10H,0f8H,23H,68H,32H,06H,11H,10H
                DB      0fcH,23H,6eH,0cH,23H,0d8H,27H,00H
                DB      00H,0c2H,0aH,00H,00H,00H,0eH,0bH
                DB      11H,11H,0f8H,0fdH,62H,76H,74H,72H
                DB      61H,76H,21H,24H,0a4H,27H,00H,00H
                DB      06H,0bH,00H,00H,00H,00H,0eH,0bH
                DB      18H,00H,00H,00H,74H,00H,00H,43H
                DB      6fH,6dH,70H,75H,74H,65H,4dH,61H
                DB      67H,69H,63H,0bH,11H,10H,1cH,6eH
                DB      63H,65H,6eH,74H,65H,72H,0dH,11H
                DB      10H,28H,73H,66H,61H,63H,65H,4cH
                DB      69H,73H,74H,0eH,11H,10H,0e8H,6bH
                DB      74H,65H,78H,66H,61H,63H,74H,6fH
                DB      72H,11H,11H,10H,0f4H,09H,70H,6fH
                DB      6cH,79H,67H,6fH,6eH,63H,6fH,75H
                DB      6eH,74H,07H,11H,10H,0f0H,09H,74H
                DB      77H,0bH,11H,10H,0f8H,23H,6cH,65H
                DB      6eH,67H,74H,65H,08H,11H,11H,14H
                DB      0ffH,5dH,6cH,30H,08H,11H,11H,3cH
                DB      0ffH,5dH,6cH,31H,08H,11H,11H,74H
                DB      0feH,5dH,6cH,32H,08H,11H,11H,0fcH
                DB      0fdH,5dH,53H,30H,08H,11H,11H,24H
                DB      0feH,5dH,53H,31H,08H,11H,11H,4cH
                DB      0feH,5dH,53H,32H,08H,11H,10H,0dcH
                DB      28H,73H,73H,31H,07H,11H,11H,9cH
                DB      0feH,5dH,50H,07H,11H,11H,0c4H,0feH
                DB      5dH,4dH,07H,11H,11H,0ecH,0feH,5dH
                DB      4eH,0aH,11H,10H,0b4H,5dH,74H,65H
                DB      6dH,70H,70H,0bH,11H,11H,64H,0ffH
                DB      5dH,74H,65H,6dH,70H,6dH,0aH,11H
                DB      10H,8cH,5dH,74H,65H,6dH,70H,6eH
                DB      0aH,11H,10H,0fcH,73H,66H,74H,72H
                DB      61H,76H,0cH,23H,0daH,32H,00H,00H
                DB      6dH,01H,00H,00H,0f6H,0eH,0aH,11H
                DB      10H,0f0H,62H,76H,74H,72H,61H,76H
                DB      23H,24H,0aaH,32H,00H,00H,0abH,01H
                DB      00H,00H,00H,00H,0eH,09H,18H,00H
                DB      00H,00H,77H,00H,01H,30H,1cH,64H
                DB      72H,61H,77H,46H,61H,63H,65H,4cH
                DB      69H,73H,74H,0dH,11H,10H,0f4H,76H
                DB      66H,61H,63H,65H,4cH,69H,73H,74H
                DB      11H,11H,10H,0f8H,09H,70H,6fH,6cH
                DB      79H,67H,6fH,6eH,63H,6fH,75H,6eH
                DB      74H,0aH,11H,10H,0fcH,76H,66H,74H
                DB      72H,61H,76H
$$SYMBOLS       ENDS

$$TYPES         SEGMENT BYTE USE16 'DEBTYP'
                DB      06H,13H,0bcH,07H,00H,00H,08H,11H
                DB      73H,74H,72H,75H,63H,74H,07H,11H
                DB      75H,6eH,69H,6fH,6eH,06H,11H,65H
                DB      6eH,75H,6dH,07H,10H,10H,63H,68H
                DB      61H,72H,0eH,10H,00H,73H,69H,67H
                DB      6eH,65H,64H,20H,63H,68H,61H,72H
                DB      10H,10H,10H,75H,6eH,73H,69H,67H
                DB      6eH,65H,64H,20H,63H,68H,61H,72H
                DB      08H,10H,01H,73H,68H,6fH,72H,74H
                DB      11H,10H,11H,75H,6eH,73H,69H,67H
                DB      6eH,65H,64H,20H,73H,68H,6fH,72H
                DB      74H,06H,10H,03H,69H,6eH,74H,0fH
                DB      10H,13H,75H,6eH,73H,69H,67H,6eH
                DB      65H,64H,20H,69H,6eH,74H,0bH,12H
                DB      00H,08H,77H,63H,68H,61H,72H,5fH
                DB      74H,0aH,12H,00H,0aH,73H,69H,7aH
                DB      65H,5fH,74H,0bH,12H,00H,08H,77H
                DB      63H,68H,61H,72H,5fH,74H,07H,10H
                DB      30H,76H,6fH,69H,64H,04H,72H,0eH
                DB      00H,03H,46H,0fH,0cH,12H,00H,10H
                DB      6fH,6eH,65H,78H,69H,74H,5fH,74H
                DB      03H,46H,04H,04H,20H,00H,12H,0dH
                DB      12H,00H,13H,5fH,5fH,76H,61H,5fH
                DB      6cH,69H,73H,74H,07H,10H,03H,6cH
                DB      6fH,6eH,67H,0aH,12H,00H,15H,66H
                DB      70H,6fH,73H,5fH,74H,0aH,12H,00H
                DB      15H,66H,70H,6fH,73H,5fH,74H,0dH
                DB      12H,00H,09H,70H,74H,72H,64H,69H
                DB      66H,66H,5fH,74H,0bH,12H,00H,09H
                DB      62H,6fH,6fH,6cH,65H,61H,6eH,08H
                DB      12H,00H,19H,66H,6cH,61H,67H,09H
                DB      12H,00H,09H,43H,4fH,4cH,4fH,52H
                DB      09H,12H,00H,09H,43H,4fH,4cH,4fH
                DB      52H,09H,12H,00H,06H,75H,63H,68H
                DB      61H,72H,0aH,12H,00H,08H,75H,73H
                DB      68H,6fH,72H,74H,08H,12H,00H,0aH
                DB      75H,69H,6eH,74H,10H,10H,13H,75H
                DB      6eH,73H,69H,67H,6eH,65H,64H,20H
                DB      6cH,6fH,6eH,67H,09H,12H,00H,20H
                DB      75H,6cH,6fH,6eH,67H,08H,12H,00H
                DB      07H,62H,6fH,6fH,6cH,08H,10H,23H
                DB      66H,6cH,6fH,61H,74H,0bH,12H,01H
                DB      80H,2bH,73H,75H,72H,66H,5fH,73H
                DB      03H,46H,24H,04H,20H,02H,23H,08H
                DB      60H,01H,00H,0cH,00H,00H,00H,05H
                DB      61H,00H,26H,76H,0bH,12H,00H,27H
                DB      70H,6fH,69H,6eH,74H,5fH,74H,0bH
                DB      12H,01H,80H,2eH,65H,64H,67H,65H
                DB      5fH,73H,03H,46H,29H,08H,60H,0cH
                DB      00H,48H,00H,00H,00H,09H,61H,44H
                DB      23H,64H,69H,6eH,76H,7aH,08H,61H
                DB      40H,23H,69H,6eH,76H,7aH,08H,61H
                DB      3cH,2aH,65H,64H,67H,65H,09H,61H
                DB      38H,09H,73H,74H,61H,74H,65H,0dH
                DB      61H,34H,09H,76H,69H,73H,78H,73H
                DB      74H,61H,72H,74H,0cH,61H,30H,09H
                DB      62H,73H,70H,64H,65H,70H,74H,68H
                DB      05H,61H,24H,28H,43H,05H,61H,18H
                DB      28H,42H,05H,61H,0cH,28H,41H,09H
                DB      61H,08H,09H,63H,6fH,6cH,6fH,72H
                DB      09H,61H,04H,25H,70H,70H,72H,65H
                DB      76H,09H,61H,00H,25H,70H,6eH,65H
                DB      78H,74H,0aH,12H,00H,24H,73H,75H
                DB      72H,66H,5fH,74H,03H,46H,2cH,08H
                DB      60H,09H,00H,24H,00H,00H,00H,0fH
                DB      61H,20H,2aH,70H,6eH,65H,78H,74H
                DB      72H,65H,6dH,6fH,76H,65H,09H,61H
                DB      1cH,2aH,70H,70H,72H,65H,76H,09H
                DB      61H,18H,2aH,70H,6eH,65H,78H,74H
                DB      09H,61H,14H,2dH,70H,73H,75H,72H
                DB      66H,09H,61H,10H,23H,64H,69H,6eH
                DB      76H,7aH,08H,61H,0cH,23H,69H,6eH
                DB      76H,7aH,0bH,61H,08H,09H,6cH,65H
                DB      61H,64H,69H,6eH,67H,09H,61H,04H
                DB      09H,78H,73H,74H,65H,70H,05H,61H
                DB      00H,09H,78H,0aH,12H,00H,29H,65H
                DB      64H,67H,65H,5fH,74H,05H,21H,0ffH
                DB      07H,2fH,08H,60H,08H,00H,38H,00H
                DB      00H,00H,09H,61H,34H,09H,63H,6fH
                DB      6cH,6fH,72H,05H,61H,28H,28H,43H
                DB      05H,61H,1cH,28H,42H,05H,61H,10H
                DB      28H,41H,09H,61H,0cH,09H,63H,6fH
                DB      75H,6eH,74H,05H,61H,08H,23H,7aH
                DB      05H,61H,04H,09H,79H,05H,61H,00H
                DB      09H,78H,0aH,12H,00H,31H,73H,70H
                DB      61H,6eH,5fH,74H,05H,21H,1fH,4eH
                DB      32H,08H,60H,02H,00H,10H,00H,00H
                DB      00H,0aH,61H,04H,28H,6eH,6fH,72H
                DB      6dH,61H,6cH,0cH,61H,00H,23H,64H
                DB      69H,73H,74H,61H,6eH,63H,65H,0bH
                DB      12H,00H,34H,70H,6cH,61H,6eH,65H
                DB      5fH,74H,04H,20H,03H,35H,03H,46H
                DB      2fH,05H,21H,0ffH,07H,37H,09H,10H
                DB      27H,64H,6fH,75H,62H,6cH,65H,05H
                DB      21H,0b7H,0bH,2cH,03H,46H,0eH,05H
                DB      21H,0cdH,00H,04H,08H,60H,21H,00H
                DB      00H,01H,00H,00H,08H,61H,32H,3cH
                DB      72H,65H,73H,32H,14H,61H,30H,07H
                DB      4fH,66H,66H,53H,63H,72H,65H,65H
                DB      6eH,4dH,65H,6dH,53H,69H,7aH,65H
                DB      16H,61H,2cH,21H,4fH,66H,66H,53H
                DB      63H,72H,65H,65H,6eH,4dH,65H,6dH
                DB      4fH,66H,66H,73H,65H,74H,0fH,61H
                DB      28H,21H,50H,68H,79H,73H,42H,61H
                DB      73H,65H,50H,74H,72H,17H,61H,27H
                DB      04H,44H,69H,72H,65H,63H,74H,43H
                DB      6fH,6cH,6fH,72H,4dH,6fH,64H,65H
                DB      49H,6eH,66H,6fH,15H,61H,26H,04H
                DB      52H,73H,76H,64H,46H,69H,65H,6cH
                DB      64H,50H,6fH,73H,69H,74H,69H,6fH
                DB      6eH,10H,61H,25H,04H,52H,73H,76H
                DB      64H,4dH,61H,73H,6bH,53H,69H,7aH
                DB      65H,15H,61H,24H,04H,42H,6cH,75H
                DB      65H,46H,69H,65H,6cH,64H,50H,6fH
                DB      73H,69H,74H,69H,6fH,6eH,10H,61H
                DB      23H,04H,42H,6cH,75H,65H,4dH,61H
                DB      73H,6bH,53H,69H,7aH,65H,16H,61H
                DB      22H,04H,47H,72H,65H,65H,6eH,46H
                DB      69H,65H,6cH,64H,50H,6fH,73H,69H
                DB      74H,69H,6fH,6eH,11H,61H,21H,04H
                DB      47H,72H,65H,65H,6eH,4dH,61H,73H
                DB      6bH,53H,69H,7aH,65H,14H,61H,20H
                DB      04H,52H,65H,64H,46H,69H,65H,6cH
                DB      64H,50H,6fH,73H,69H,74H,69H,6fH
                DB      6eH,0fH,61H,1fH,04H,52H,65H,64H
                DB      4dH,61H,73H,6bH,53H,69H,7aH,65H
                DB      08H,61H,1eH,04H,72H,65H,73H,31H
                DB      16H,61H,1dH,04H,4eH,75H,6dH,62H
                DB      65H,72H,4fH,66H,49H,6dH,61H,67H
                DB      65H,50H,61H,67H,65H,73H,0cH,61H
                DB      1cH,04H,42H,61H,6eH,6bH,53H,69H
                DB      7aH,65H,0fH,61H,1bH,04H,4dH,65H
                DB      6dH,6fH,72H,79H,4dH,6fH,64H,65H
                DB      6cH,11H,61H,1aH,04H,4eH,75H,6dH
                DB      62H,65H,72H,4fH,66H,42H,61H,6eH
                DB      6bH,73H,10H,61H,19H,04H,42H,69H
                DB      74H,73H,50H,65H,72H,50H,69H,78H
                DB      65H,6cH,12H,61H,18H,04H,4eH,75H
                DB      6dH,62H,65H,72H,4fH,66H,50H,6cH
                DB      61H,6eH,65H,73H,0dH,61H,17H,04H
                DB      59H,43H,68H,61H,72H,53H,69H,7aH
                DB      65H,0dH,61H,16H,04H,58H,43H,68H
                DB      61H,72H,53H,69H,7aH,65H,0fH,61H
                DB      14H,07H,59H,52H,65H,73H,6fH,6cH
                DB      75H,74H,69H,6fH,6eH,0fH,61H,12H
                DB      07H,58H,52H,65H,73H,6fH,6cH,75H
                DB      74H,69H,6fH,6eH,14H,61H,10H,07H
                DB      42H,79H,74H,65H,73H,50H,65H,72H
                DB      53H,63H,61H,6eH,4cH,69H,6eH,65H
                DB      0eH,61H,0cH,3bH,57H,69H,6eH,46H
                DB      75H,6eH,63H,50H,74H,72H,0fH,61H
                DB      0aH,07H,57H,69H,6eH,42H,53H,65H
                DB      67H,6dH,65H,6eH,74H,0fH,61H,08H
                DB      07H,57H,69H,6eH,41H,53H,65H,67H
                DB      6dH,65H,6eH,74H,0bH,61H,06H,07H
                DB      57H,69H,6eH,53H,69H,7aH,65H,12H
                DB      61H,04H,07H,57H,69H,6eH,47H,72H
                DB      61H,6eH,75H,6cH,61H,72H,69H,74H
                DB      79H,12H,61H,03H,04H,57H,69H,6eH
                DB      42H,41H,74H,74H,72H,69H,62H,75H
                DB      74H,65H,73H,12H,61H,02H,04H,57H
                DB      69H,6eH,41H,41H,74H,74H,72H,69H
                DB      62H,75H,74H,65H,73H,12H,61H,00H
                DB      07H,4dH,6fH,64H,65H,41H,74H,74H
                DB      72H,69H,62H,75H,74H,65H,73H,10H
                DB      12H,00H,3dH,56H,42H,45H,5fH,6dH
                DB      6fH,64H,65H,49H,6eH,66H,6fH,05H
                DB      21H,0b7H,0bH,2fH,04H,20H,11H,28H
                DB      08H,60H,0bH,00H,3cH,01H,00H,00H
                DB      0aH,62H,2cH,01H,35H,70H,6cH,61H
                DB      6eH,65H,09H,61H,54H,40H,76H,65H
                DB      72H,74H,73H,0cH,61H,50H,09H,6eH
                DB      75H,6dH,76H,65H,72H,74H,73H,0cH
                DB      61H,4cH,09H,62H,73H,70H,64H,65H
                DB      70H,74H,68H,05H,61H,40H,28H,43H
                DB      05H,61H,34H,28H,42H,05H,61H,28H
                DB      28H,41H,05H,61H,1cH,28H,4eH,05H
                DB      61H,10H,28H,4dH,05H,61H,04H,28H
                DB      50H,09H,61H,00H,09H,63H,6fH,6cH
                DB      6fH,72H,0dH,12H,00H,41H,70H,6fH
                DB      6cH,79H,67H,6fH,6eH,5fH,74H,03H
                DB      46H,06H,04H,20H,02H,23H,04H,20H
                DB      02H,44H,04H,20H,02H,23H,04H,20H
                DB      02H,46H,04H,20H,02H,23H,04H,20H
                DB      02H,48H,03H,46H,3eH,05H,72H,1eH
                DB      01H,4aH,03H,46H,35H,08H,60H,03H
                DB      00H,0cH,00H,00H,00H,05H,61H,08H
                DB      23H,7aH,05H,61H,04H,23H,79H,05H
                DB      61H,00H,23H,78H,0dH,12H,00H,4dH
                DB      70H,6fH,69H,6eH,74H,32H,44H,5fH
                DB      74H,04H,20H,11H,4eH,08H,60H,02H
                DB      00H,0dcH,00H,00H,00H,09H,61H,04H
                DB      4fH,76H,65H,72H,74H,73H,0cH,61H
                DB      00H,09H,6eH,75H,6dH,76H,65H,72H
                DB      74H,73H,0fH,12H,00H,50H,70H,6fH
                DB      6cH,79H,67H,6fH,6eH,32H,44H,5fH
                DB      74H,03H,46H,51H,06H,72H,0eH,02H
                DB      4cH,52H,05H,72H,0eH,01H,0eH,03H
                DB      46H,32H,03H,46H,42H,05H,72H,0eH
                DB      01H,56H,0eH,12H,01H,80H,5cH,76H
                DB      65H,72H,74H,65H,78H,54H,61H,67H
                DB      03H,46H,58H,08H,60H,04H,00H,10H
                DB      00H,00H,00H,06H,61H,0cH,23H,64H
                DB      64H,06H,61H,08H,23H,63H,63H,06H
                DB      61H,04H,23H,62H,62H,06H,61H,00H
                DB      23H,61H,61H,09H,12H,00H,5aH,50H
                DB      4cH,41H,4eH,45H,08H,60H,07H,00H
                DB      28H,00H,00H,00H,09H,61H,18H,5bH
                DB      70H,6cH,61H,6eH,65H,09H,61H,14H
                DB      59H,76H,6eH,65H,78H,74H,06H,61H
                DB      10H,23H,76H,76H,06H,61H,0cH,23H
                DB      75H,75H,06H,61H,08H,23H,7aH,7aH
                DB      06H,61H,04H,23H,79H,79H,06H,61H
                DB      00H,23H,78H,78H,0aH,12H,00H,58H
                DB      56H,45H,52H,54H,45H,58H,05H,72H
                DB      09H,01H,0eH,06H,72H,0eH,02H,56H
                DB      52H,03H,46H,28H,06H,72H,0eH,02H
                DB      60H,60H,03H,46H,5dH,06H,72H,0eH
                DB      02H,60H,62H,06H,72H,0eH,02H,56H
                DB      56H,07H,72H,09H,03H,56H,4cH,28H
                DB      06H,72H,0eH,02H,60H,4cH,07H,72H
                DB      09H,03H,56H,4cH,56H,06H,72H,09H
                DB      02H,56H,56H,04H,20H,01H,42H,08H
                DB      60H,02H,00H,08H,00H,00H,00H,05H
                DB      61H,04H,23H,79H,05H,61H,00H,23H
                DB      78H,0eH,12H,00H,6aH,74H,65H,78H
                DB      63H,6fH,6fH,72H,64H,5fH,74H,09H
                DB      72H,6bH,05H,5dH,5dH,5dH,23H,23H
                DB      08H,60H,03H,00H,0cH,00H,00H,00H
                DB      06H,61H,08H,23H,7aH,7aH,06H,61H
                DB      04H,23H,79H,79H,06H,61H,00H,23H
                DB      78H,78H,09H,12H,00H,6dH,50H,4fH
                DB      49H,4eH,54H,0cH,12H,01H,80H,71H
                DB      66H,61H,63H,65H,54H,61H,67H,03H
                DB      46H,6fH,08H,60H,08H,00H,98H,00H
                DB      00H,00H,09H,61H,94H,70H,66H,6eH
                DB      65H,78H,74H,09H,61H,84H,5bH,70H
                DB      6cH,61H,6eH,65H,09H,61H,80H,62H
                DB      76H,68H,65H,61H,64H,0cH,61H,7cH
                DB      09H,62H,73H,70H,64H,65H,70H,74H
                DB      68H,05H,61H,54H,5dH,4eH,05H,61H
                DB      2cH,5dH,4dH,05H,61H,04H,5dH,50H
                DB      09H,61H,00H,1bH,63H,6fH,6cH,6fH
                DB      72H,08H,12H,00H,6fH,46H,41H,43H
                DB      45H,03H,46H,72H,06H,72H,0eH,02H
                DB      6eH,73H,08H,12H,00H,6fH,46H,41H
                DB      43H,45H,03H,46H,75H,05H,72H,0eH
                DB      01H,76H,02H,14H
$$TYPES         ENDS

$$TYPES         SEGMENT BYTE USE16 'DEBTYP'
                DB      00H,00H,15H,00H,00H,00H,1dH,00H
                DB      3aH,00H,5bH,00H,70H,00H,82H,00H
                DB      94H,00H,0a6H,00H,0baH,00H,0cdH,00H
                DB      0e2H,00H,0f4H,00H,09H,01H,27H,01H
                DB      3cH,01H,5cH,01H,7bH,01H,9bH,01H
                DB      0bdH,01H,0deH,01H,0fdH,01H,44H,3aH
                DB      5cH,43H,4fH,44H,49H,4eH,47H,5cH
                DB      45H,4eH,47H,49H,4eH,45H,5cH,30H
                DB      33H,30H,36H,39H,37H,5cH,33H,64H
                DB      2eH,63H,00H,44H,3aH,5cH,43H,4fH
                DB      44H,49H,4eH,47H,5cH,45H,4eH,47H
                DB      49H,4eH,45H,5cH,30H,33H,30H,36H
                DB      39H,37H,5cH,33H,64H,2eH,68H,00H
                DB      44H,3aH,5cH,43H,4fH,44H,49H,4eH
                DB      47H,5cH,45H,4eH,47H,49H,4eH,45H
                DB      5cH,30H,33H,30H,36H,39H,37H,5cH
                DB      67H,6cH,6fH,62H,61H,6cH,2eH,68H
                DB      00H,64H,3aH,5cH,77H,61H,74H,63H
                DB      6fH,6dH,5cH,48H,5cH,73H,74H,64H
                DB      6cH,69H,62H,2eH,68H,00H,64H,3aH
                DB      5cH,77H,61H,74H,63H,6fH,6dH,5cH
                DB      48H,5cH,49H,38H,36H,2eH,68H,00H
                DB      64H,3aH,5cH,77H,61H,74H,63H,6fH
                DB      6dH,5cH,48H,5cH,64H,6fH,73H,2eH
                DB      68H,00H,64H,3aH,5cH,77H,61H,74H
                DB      63H,6fH,6dH,5cH,48H,5cH,69H,38H
                DB      36H,2eH,68H,00H,64H,3aH,5cH,77H
                DB      61H,74H,63H,6fH,6dH,5cH,48H,5cH
                DB      73H,74H,64H,69H,6fH,2eH,68H,00H
                DB      64H,3aH,5cH,77H,61H,74H,63H,6fH
                DB      6dH,5cH,48H,5cH,6dH,61H,74H,68H
                DB      2eH,68H,00H,64H,3aH,5cH,77H,61H
                DB      74H,63H,6fH,6dH,5cH,48H,5cH,6dH
                DB      61H,6cH,6cH,6fH,63H,2eH,68H,00H
                DB      64H,3aH,5cH,77H,61H,74H,63H,6fH
                DB      6dH,5cH,48H,5cH,6dH,65H,6dH,2eH
                DB      68H,00H,64H,3aH,5cH,77H,61H,74H
                DB      63H,6fH,6dH,5cH,48H,5cH,73H,74H
                DB      72H,69H,6eH,67H,2eH,68H,00H,44H
                DB      3aH,5cH,43H,4fH,44H,49H,4eH,47H
                DB      5cH,45H,4eH,47H,49H,4eH,45H,5cH
                DB      30H,33H,30H,36H,39H,37H,5cH,62H
                DB      73H,70H,2eH,68H,00H,64H,3aH,5cH
                DB      77H,61H,74H,63H,6fH,6dH,5cH,48H
                DB      5cH,61H,73H,73H,65H,72H,74H,2eH
                DB      68H,00H,44H,3aH,5cH,43H,4fH,44H
                DB      49H,4eH,47H,5cH,45H,4eH,47H,49H
                DB      4eH,45H,5cH,30H,33H,30H,36H,39H
                DB      37H,5cH,67H,67H,65H,6dH,73H,2eH
                DB      68H,00H,44H,3aH,5cH,43H,4fH,44H
                DB      49H,4eH,47H,5cH,45H,4eH,47H,49H
                DB      4eH,45H,5cH,30H,33H,30H,36H,39H
                DB      37H,5cH,73H,76H,67H,61H,2eH,68H
                DB      00H,44H,3aH,5cH,43H,4fH,44H,49H
                DB      4eH,47H,5cH,45H,4eH,47H,49H,4eH
                DB      45H,5cH,30H,33H,30H,36H,39H,37H
                DB      5cH,64H,65H,62H,75H,67H,2eH,68H
                DB      00H,44H,3aH,5cH,43H,4fH,44H,49H
                DB      4eH,47H,5cH,45H,4eH,47H,49H,4eH
                DB      45H,5cH,30H,33H,30H,36H,39H,37H
                DB      5cH,76H,65H,73H,61H,76H,62H,65H
                DB      2eH,68H,00H,44H,3aH,5cH,43H,4fH
                DB      44H,49H,4eH,47H,5cH,45H,4eH,47H
                DB      49H,4eH,45H,5cH,30H,33H,30H,36H
                DB      39H,37H,5cH,33H,64H,6dH,61H,74H
                DB      68H,2eH,68H,00H,44H,3aH,5cH,43H
                DB      4fH,44H,49H,4eH,47H,5cH,45H,4eH
                DB      47H,49H,4eH,45H,5cH,30H,33H,30H
                DB      36H,39H,37H,5cH,6dH,6fH,76H,65H
                DB      2eH,68H,00H,44H,3aH,5cH,43H,4fH
                DB      44H,49H,4eH,47H,5cH,45H,4eH,47H
                DB      49H,4eH,45H,5cH,30H,33H,30H,36H
                DB      39H,37H,5cH,70H,6dH,6fH,64H,65H
                DB      2eH,68H,00H
$$TYPES         ENDS

                END
