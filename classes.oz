declare P  P1 Horarios Tratamientos Hor
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

fun {EspacioDisponibleASegmento Espacio TamanioSegmento}
   local DuplaSegmentos in
      case Espacio
      of nil then nil
      [] Dia#HoraInicio#HoraFinal then
	 local SegmentosAcumulados DuplaSegmentos in
	    SegmentosAcumulados = ((Dia - 1) * 44)
	    DuplaSegmentos = {DuplaHorariosADuplaSegmentos HoraInicio#HoraFinal TamanioSegmento}
	    (SegmentosAcumulados + DuplaSegmentos.1)#(SegmentosAcumulados + DuplaSegmentos.2)
	 end
	 
      end
   end
end

{Browse {EspacioDisponibleASegmento 2#'7:30'#'9:00' 15}}

class Point from BaseObject
	 feat r n m
   attr x:0 y:0
   meth init(X Y)
      x := X
      y := Y             % attribute update
      x := r
   end
   meth location(?L)
      L = l(x:@x y:@y)     % attribute access
   end 
   meth moveHorizontal(X)
      x := X
   end 
   meth moveVertical(Y)
      y := Y
   end 
   meth move(X Y)
      {self moveHorizontal(X)}
      {self moveVertical(Y)}
   end 
   meth display 
    % Switch the browser to virtual string mode
     {Browse "point at ("#@x#" , "#@y#")\n"}  
   end 
end
/*
P = {New Point init(2 0)}
{P display}
{P move(30 2)}
{P location(X)}
{Browse X.x}
*/

class Paciente from BaseObject
   attr
      horarios_ocupados % franjas de horarios en cada dia: ejemplo horarios(lunes: ["7:40"#"12:40" "14:00"#"18:00"] martes:["12:00"#"18:00"])
      consultas_necesarias % array de consultas de tipo atom
   meth init(HorariosOcupados ConsultasNecesarias)
      horarios_ocupados := HorariosOcupados
      consultas_necesarias := ConsultasNecesarias
   end
   
   
end

PR = {New Paciente init(['7:00'#'9:00'] [odontologia])}

class Profesional from BaseObject
   attr
      horarios % franjas de horarios en cada dia: ejemplo horarios([1#"7:40"#"12:40" "14:00"#"18:00"] 2#["12:00"#"18:00"])
      tratamientos % lista de tratamientos que atiende el profesional ej: [consulta_general limipieza_dental]
   meth getHorarios(Horarios)
      Horarios =  @horarios
   end
   meth getTratamientos(Tratamientos)
      Tratamientos = @tratamientos
   end
   meth atiendeTratamiento(Tratamiento ?Atiende)
      Atiende? = {List.member Tratamiento @tratamientos}
   end   
   meth init(Horarios Tratamientos)
      horarios := Horarios
      tratamientos := Tratamientos
   end
   meth browse
      {Browse [@horarios @tratamientos]}
   end
end


{Browse {DuplaHorariosADuplaSegmentos '13:30'#'13:45' 15}}   

Tratamientos = [consulta_general limpieza_dental urgencias_1_nivel]
Horarios =  horarios(lunes: ['7:40'#'12:40' '14:00'#'18:00'] martes:['12:00'#'18:00'])
P1 = {New Profesional init(Horarios Tratamientos)}
local Atiende? in {P1 atiendeTratamiento(consulta_general Atiende?)} {Browse Atiende? } end 
local X in {P1 getHorarios(X)} {Browse X.lunes.1.1} end

%Horario = '15:13'
%{String.token {Atom.toString Horario} &: S1 S2} 
%{Browse {String.toAtom S1}}


Pacientes = [
	     paciente(tratamientos: [ortodoncia toma_presion] horarios_no_disponibles: [1#'7:00'#'8:00'])
	     paciente(tratamientos: [ortodoncia toma_presion] horarios_no_disponibles: [1#'7:00'#'8:00'])
	    ]
Doctores = [
	    doctor(tratamientos [ortodoncia] horarios_disponibles: [1#'7:00'#'6:00'])
	    ]
{Browse Doctores}
/*local R in 
case Doctores.1.horarios_disponibles.1 of nil then R=nil
[] X#Y#Z then R=Y
end

{Browse R}

end
*/	     