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
Retorna una lista de tratamientos de la forma nombre_paciente#tratamiento basado en un record del tipo pacientes
*/
fun {DuplaTratamientos Pacientes}
   {List.flatten {Map Pacientes fun {$ Paciente } {Map Paciente.tratamientos fun {$ Tratamiento} Paciente.nombre#Tratamiento end } end }}
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

Tratamientos = [ortodoncia toma_presion otorrino examen_visual]
Horarios =  horarios(lunes: ['7:40'#'12:40' '14:00'#'18:00'] martes:['12:00'#'18:00'])
P1 = {New Profesional init(Horarios Tratamientos)}
local Atiende? in {P1 atiendeTratamiento(consulta_general Atiende?)} {Browse Atiende? } end 
local X in {P1 getHorarios(X)} {Browse X.lunes.1.1} end

%Horario = '15:13'
%{String.token {Atom.toString Horario} &: S1 S2} 
%{Browse {String.toAtom S1}}

/*local R in 
case Doctores.1.horarios_disponibles.1 of nil then R=nil
[] X#Y#Z then R=Y
end

{Browse R}

end
*/

%Crea un diccionario con objectos , donde sus llaves son ids numericos creados y los valores son los datos de la lista
proc { InitKeys List DictAux FirstValue DictResult?}
   %{Browse DictPilotos}
   case List
   of nil then DictResult = DictAux
   [] X | Xr then
      {Dictionary.put DictAux FirstValue X}
      {InitKeys Xr DictAux FirstValue + 1 DictResult}
   end
end
fun {InitKeysF List}
   local DictAux DictResult in
      DictAux = {Dictionary.new}
      DictResult = {InitKeys List DictAux 1}
      DictResult
   end
end

fun {GetDictFromList List}
   local DictAux Dict in
      DictAux = {Dictionary.new}
      {InitKeys List DictAux 0 Dict}
      Dict
   end
end
Pacientes = [  paciente(nombre:luis tratamientos: [ortodoncia toma_presion] horarios_no_disponibles: [1#'7:00'#'8:00'])  paciente(nombre: alberto tratamientos: [ortodoncia toma_presion otorrino examen_visual] horarios_no_disponibles: [1#'7:00'#'8:00'])   ]

Doctores = [ doctor( nombre: jhon tratamientos: [ortodoncia toma_presion otorrino] horarios_disponibles: [1#'7:00'#'10:00' 1#'10:30'#'12:00']) doctor(nombre: juan tratamientos: [otorrino examen_visual] horarios_disponibles: [1#'10:00'#'12:00']) ]

/*
Dado un record de doctores, devuelve una lista de duplas de la forma nombre#franja_disponible
*/
fun {GetDuplasHorariosDisponibles Doctores }
   {List.flatten {Map Doctores fun {$ Doctor}  {Map Doctor.horarios_disponibles fun {$ Horario_disponible} Doctor.nombre#{EspacioDisponibleASegmento Horario_disponible 15} end } end } }
end

/*
Dado un record de doctores y un tratamiento devuelve una lista de nombres de doctores que atienden ese tratamiento
*/

fun {GetListDoctoresAtiendenTratamiento Tratamiento Doctores}
   {List.subtract  {Map Doctores fun {$ Doctor} if {List.member Tratamiento Doctor.tratamientos} then Doctor.nombre else nil end end } nil}
end

/*
 Dado un record de doctores y una lista de tratamientos, devuelve un record de la forma tratamiento:[nombres_de_doctores_que_atienden]
*/

fun {GetRecordDoctoresAtiendenTratamientos Tratamientos Doctores}
   Rec = {Record.make doctores_atienden_tratamientos Tratamientos }
in
   {ForAll Tratamientos proc {$ Tratamiento} Rec.Tratamiento = {GetListDoctoresAtiendenTratamiento Tratamiento Doctores} end }
   Rec
end
/*
Retorna una lista de franjas individuales disponibles con base en un doctor
*/
fun {FranjasDisponibles Doctor TamanioFranja}
   local Resultado in
      Resultado = {List.flatten {Map Doctor.horarios_disponibles
		     fun {$ HorarioDisponible}
			local SegmentoDisponible in
			   SegmentoDisponible = {EspacioDisponibleASegmento HorarioDisponible TamanioFranja}
			   {List.number SegmentoDisponible.1 SegmentoDisponible.2 1}
			end
		     end
				}
		  }
      Resultado
      end
end

/*
Retorna un record de la forma nombre_doctor: [lista de franjas individuales disponibles]
*/

fun {RecordFranjasDisponibles NombresDoctores Doctores TamanioFranja}
   local RecordFranjas in
      RecordFranjas = {Record.make franjasDisponibles NombresDoctores}
      {ForAll Doctores proc {$ Doctor} local Nombre in
					  Nombre = Doctor.nombre
					  RecordFranjas.Nombre = {FranjasDisponibles Doctor TamanioFranja}
				       end
		       end
       }
      RecordFranjas
   end
end

   
proc {AsignacionCitas Root}
   /*
   El modelo a resolver sera:
			   citas_paciente [tratamiento: fd1#n]
   citas_doctor [doctor:horario]
   */
   NumFranjas = 80
   DictTratamientos = {GetDictFromList {DuplaTratamientos Pacientes}}
   NumTratamientos = {List.length {Dictionary.keys DictTratamientos}}
   NumPacientes = {List.length {Record.toList Pacientes}}
   NumDoctores = {List.length {Record.toList Doctores}}
   DuplasHorariosDiponiblesDoctores = {GetDuplasHorariosDisponibles Doctores}
   DictFranjasDoctores = 5
   DoctoresAtiendenTratamientos = {GetRecordDoctoresAtiendenTratamientos Tratamientos  Doctores}
   NombresDoctores = {Map Doctores fun {$ Doctor} Doctor.nombre end}
   %Requerimiento tratamientos de la forma nombre_tratamiento:cantidad_requerida, cantidad de tratamientos requeridos de el tipo nombre_tratamiento
   RecRequerimientosTratamientos = {Record.make requerimiento_tratamientos Tratamientos}
   RecFranjasDisponibles = {RecordFranjasDisponibles NombresDoctores Doctores 15}
   FDCitasAtendidasDoctores = {Record.make citas_atendidas NombresDoctores}
   {ForAll NombresDoctores  proc {$ NombreDoctor} FDCitasAtendidasDoctores.NombreDoctor = {FD.list NumFranjas 0#1} end }
  
in
   % un medico tiene unas franjas disponibles, las demas no podra atender
   {ForAll NombresDoctores proc {$ NombreDoctor}
			      {For 1 NumFranjas 1
			       proc {$ Index}
				  if {List.member Index RecFranjasDisponibles.NombreDoctor} then
				     skip
				  else
				    
				     {List.nth FDCitasAtendidasDoctores.NombreDoctor Index} =: 0
				  end
			       end
			      }
			   end
     }
   {Browse RecFranjasDisponibles}
   {Browse FDCitasAtendidasDoctores}
end


{Browse {FranjasDisponibles Doctores.1 15}}
{AsignacionCitas 5}