(define (problem Planificaio)
   (:domain Planificacio)
   (:objects rover1 rover2 rover3 rover4 - rover
        p1 p2 p3 p4 p5 - personal
        s1 s2 s3 s4 s5 - subministrament
        a1 a2 a3 a4 a5 - assentament
        m1 m2 m3 m4 m5 - magatzem
    )

   (:init
     (= (places rover1) 0)
     (estacionat rover1 a1)
     (= (places rover2) 0)
     (estacionat rover2 m3)
     (= (places rover3) 0)
     (estacionat rover3 a5)
     (= (places rover4) 0)
     (estacionat rover4 m2)
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
     (disponible p2 a4)
     (disponible p3 a2)
     (disponible p4 a4)
     (disponible p5 a3)
     (disponible s1 m1)
     (disponible s2 m3)
     (disponible s3 m2)
     (disponible s4 m5)
     (disponible s5 m4)
     (peticio p1 a5)
     (peticio p2 a5)
     (peticio p3 a5)
     (peticio p4 a5)
     (peticio p5 a5)
     (peticio s1 a5)
     (peticio s2 a5)
     (peticio s3 a5)
     (peticio s4 a5)
     (peticio s5 a5)
   )
   (:goal (and (forall (?o - personal) (entregat ?o)) (forall (?o - subministrament) (entregat ?o)))
   )
)