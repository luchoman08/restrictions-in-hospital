
declare P X P1 Horarios Tratamientos Hor
class Point from BaseObject
	 feat r n m
   attr x:0 y:0
   meth init(X Y)
      x := X
      y := Y             % attribute update
      x := r
   end
   meth location(L)
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

P = {New Point init(2 0)}
{P display}
{P move(30 2)}
P.r = 90
{Browse P.r}
{P location(X)}
{Browse X}


class Profesional from BaseObject
   attr
      horarios % franjas de horarios en cada dia: ejemplo horarios(lunes: [6#12 2#6] martes:[12#6])
      tratamientos % lista de tratamientos que atiende el profesional ej: [consulta_general limipieza_dental]
   meth getHorarios(Horarios)
      Horarios =  @horarios
   end
   meth getTratamientos(Tratamientos)
      Tratamientos := @tratamientos
   end
   meth atiendeTratamiento(Tratamiento Atiende?)
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
Tratamientos = [consulta_general limpieza_dental urgencias_1_nivel]
Horarios = horarios(lunes: [6#12 2#6] martes:[12#6])
P1 = {New Profesional init(Horarios Tratamientos)}
{Browse Tratamientos.1}
local Atiende? in {P1 atiendeTratamiento(consulta_general Atiende?)} {Browse Atiende? } end 
local X in {P1 getHorarios(X)} {Browse X.lunes.1.1} end

{Browse 12#4}