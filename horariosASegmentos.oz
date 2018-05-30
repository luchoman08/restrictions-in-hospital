declare 
Horario = '13:30'
/*
Devuelve el segmento correspondiente a una hora en especifico
@input Horario:Atom Atomo en formato 'hora:minuto', donde hora esta en formato 24 horas sin ceros al inicio para las horas menores a 12
@input TamanioSegmento:Int tamaño del segmento a analizar, en minutos
@return Segmento:Int segmento correspondiente para las entradas dadas
*/
fun {HorarioASegmento Horario TamanioSegmento}
   local S1 S2 Y3 Y4 in
      {String.token {Atom.toString Horario} &: S1 S2}
     
      {String.toInt S1 Y3}
      
      {String.toInt S2 Y4}
      (((Y3 - 7) * 4) + {Float.toInt {Int.toFloat Y4} / {Int.toFloat TamanioSegmento}})
   end
end

/*
Devuelve una dupla de segmentos basada en una dupla de horarios
@input Horario1#Horario2:Atom#Atom cada horario esta ne formato 'hora:minuto', donde hora esta en formato 24 horas sin ceros al inicio para las horas menores a 12
@input TamanioSegmento:Int tamaño del segmento a analizar, en minutos
@return Segmento1#Segmento2:Int1#Int2 dupla de segmentos correspondiente para las entradas dadas
*/

fun {DuplaHorariosADuplaSegmentos DuplaHorario TamanioSegmento}
   case DuplaHorario
   of nil then nil
   [] X#Y then  {HorarioASegmento X TamanioSegmento}#{HorarioASegmento Y TamanioSegmento}
   [] X then nil
   end
end

{Browse {DuplaHorariosADuplaSegmentos '13:30'#'13:45' 15}}

{Browse {HorarioASegmento '13:45' 15}}
PR = 1#2
{Browse PR.2}