(define (problem Planificaio)
   (:domain Planificacio)
   (:objects rover1 - rover
        p1 p2 p3 p4 p5 - personal
        a1 a2 a3 a4 a5 - assentament
        m1 m2 m3 m4 m5 - magatzem
    )
 
   (:init
     (estacionat rover1 m1)
     (cami a1 m1)
     (cami m1 a2)
     (cami a2 m2)
     (cami m2 a3)
     (cami a3 m3)
     (cami m3 a4)
     (cami a4 m4)
     (cami m4 a5)
     (cami a5 m5)
     (cami m5 a1)
     (disponible p1 a1)
     (disponible p2 a2)
     (disponible p3 a3)
     (disponible p4 a4)
     (disponible p5 a5)
     (peticio p1 a5)
     (peticio p2 a4)
     (peticio p3 a3)
     (peticio p4 a2)
     (peticio p5 a1)
   )
   (:goal (forall (?o - object) (servit ?o))
   )
)