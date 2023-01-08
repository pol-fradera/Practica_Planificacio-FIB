(define (domain Planificacio)
   (:requirements :adl :typing :fluents)

   (:types assentament magatzem - base
	   personal subministrament - object
       rover
   )

   (:predicates
     (estacionat ?r - rover ?b - base)
     (disponible ?o - object ?b - base)
     (en ?o - object ?r - rover)
     (entregat ?o - object)
     (peticio ?o - object ?b - assentament)
     (cami ?b1 - base ?b2 - base)
     (prioritat1 ?o - object ?b - assentament)
     (prioritat2 ?o - object ?b - assentament)
     (prioritat3 ?o - object ?b - assentament)
   )

   (:functions
     (places ?r - rover)
     (combustible ?r - rover)
     (prioritat_total)
   )

   (:action agafar_subministrament
     :parameters (?o - subministrament ?r - rover ?b - magatzem)
     :precondition (and (disponible ?o ?b) (estacionat ?r ?b) (< (places ?r) 1))
     :effect (and (not (disponible ?o ?b)) (en ?o ?r) (increase (places ?r) 2))
   )

   (:action agafar_personal
     :parameters (?o - personal ?r - rover ?b - assentament)
     :precondition (and (disponible ?o ?b) (estacionat ?r ?b) (< (places ?r) 2))
     :effect (and (not (disponible ?o ?b)) (en ?o ?r) (increase (places ?r) 1))
   )

   (:action entregar_subministrament
     :parameters (?o - subministrament ?r - rover ?b - assentament)
     :precondition (and (estacionat ?r ?b) (en ?o ?r) (peticio ?o ?b))
     :effect (and (entregat ?o) (not (en ?o ?r)) (decrease (places ?r) 2)
             (when (prioritat3 ?o ?b) (increase (prioritat_total) 10))
             (when (prioritat2 ?o ?b) (increase (prioritat_total) 20))
             (when (prioritat1 ?o ?b) (increase (prioritat_total) 30))
             )
   )

   (:action entregar_personal
        :parameters (?o - personal ?r - rover ?b - assentament)
        :precondition (and (estacionat ?r ?b) (en ?o ?r) (peticio ?o ?b))
        :effect (and (entregat ?o) (not (en ?o ?r)) (decrease (places ?r) 1)
                (when (prioritat3 ?o ?b) (increase (prioritat_total) 10))
                (when (prioritat2 ?o ?b) (increase (prioritat_total) 20))
                (when (prioritat1 ?o ?b) (increase (prioritat_total) 30))
                )
   )

   (:action moure_rover
     :parameters (?r - rover ?o - base ?d - base)
     :precondition (and (estacionat ?r ?o) (or (cami ?o ?d) (cami ?d ?o)) (> (combustible ?r) 0))
     :effect (and (estacionat ?r ?d) (not (estacionat ?r ?o)) (decrease (combustible ?r) 1))
   )
)