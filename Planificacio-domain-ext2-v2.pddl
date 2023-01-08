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
   )

   (:functions
     (places ?r - rover)
     (combustible ?r - rover)
     (combustible_total)
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
     :effect (and (entregat ?o) (not (en ?o ?r)) (decrease (places ?r) 2))
   )

   (:action entregar_personal
        :parameters (?o - personal ?r - rover ?b - assentament)
        :precondition (and (estacionat ?r ?b) (en ?o ?r) (peticio ?o ?b))
        :effect (and (entregat ?o) (not (en ?o ?r)) (decrease (places ?r) 1))
   )

   (:action moure_rover
     :parameters (?r - Rover ?o - base ?d - base)
     :precondition (and (estacionat ?r ?o) (or (cami ?o ?d) (cami ?d ?o)) (> (combustible ?r) 0))
     :effect (and (estacionat ?r ?d) (not (estacionat ?r ?o)) (decrease (combustible ?r) 1) (decrease (combustible_total) 1))
   )
)