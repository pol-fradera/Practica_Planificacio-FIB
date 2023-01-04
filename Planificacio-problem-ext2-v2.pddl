(define (problem Planificaio)
   (:domain Planificacio)
   (:objects rover1 - rover
        p1 p2 p3 - personal
        s1 s2 s3 - subministrament
        a1 a2 a3 a4 a5 - assentament
        m1 m2 m3 m4 m5 - magatzem
   )

   (:init
     (= (places rover1) 0)
     (estacionat rover1 a1)
     (= (combustible rover1) 100)
     (= combustible_total 100)
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
     (disponible s1 m1)
     (disponible s2 m3)
     (disponible s3 m4)
     (peticio p1 a5)
     (peticio p2 a3)
     (peticio p3 a2)
     (peticio s1 a4)
     (peticio s2 a3)
     (peticio s3 a1)
   )

   (:goal (and (forall (?o - personal) (servit ?o)) (forall (?o - subministrament) (servit ?o)))
   )
   (:metric maximize (combustible_total))
)