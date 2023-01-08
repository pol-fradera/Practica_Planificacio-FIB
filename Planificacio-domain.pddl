(define (domain Planificacio)
   (:requirements :adl :typing)

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

   (:action agafar_subministrament
     :parameters (?o - subministrament ?r - rover ?b - magatzem)
     :precondition (and (disponible ?o ?b) (estacionat ?r ?b))
     :effect (and (not (disponible ?o ?b)) (en ?o ?r))
   )

   (:action agafar_personal
     :parameters (?o - personal ?r - rover ?b - assentament)
     :precondition (and (disponible ?o ?b) (estacionat ?r ?b))
     :effect (and (not (disponible ?o ?b)) (en ?o ?r))
   )

   (:action entregar
     :parameters (?o - object ?r - rover ?b - assentament)
     :precondition (and (estacionat ?r ?b) (en ?o ?r) (peticio ?o ?b))
     :effect (and (entregat ?o) (not (en ?o ?r)))
   )

   (:action moure_rover
     :parameters (?r - Rover ?o - base ?d - base)
     :precondition (and (estacionat ?r ?o) (or (cami ?o ?d) (cami ?d ?o)))
     :effect (and (estacionat ?r ?d) (not (estacionat ?r ?o)))
   )
)