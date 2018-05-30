declare A B C R

A :: 0#1
B :: 0#2
C :: 0#4
C =: 1
A =: C
%{FD.conj A B C}
{FD.record pacientes [horas_disponibles citas_pendientes]  0#10 R}
R.citas_pendientes <: B 
{Browse [A B C R]  }
