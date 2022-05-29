(*****************************************************************)
(* Langages de Programmation: IFT 3000 ÉTÉ 2022                  *)
(* TP1. Date limite: Mercredi 08 juin à 17h00                    *)
(* Manipulation d'un plan en utilisant des                       *)
(* listes et des enregistrements.                                *)
(*****************************************************************)


(*****************************************************************)
(* Signature du PLAN 			                         *)
(*****************************************************************)

module type PLAN = sig

	exception  Err of string

	type nom_client = string
        type demande_client = int
	type num_itineraire = int
        type capacite_itineraire = int
	type client  =  {nom : nom_client; demande : demande_client}
	type itineraire = {num : num_itineraire;
                           capacite : capacite_itineraire; liste_clients : client list}
	type plan = Vide |Ilist of itineraire list

	val initialiser_plan : unit -> plan
	val creer_client : nom_client ->  demande_client  -> client
	val creer_itineraire :  capacite_itineraire  -> itineraire
	val retourner_liste_clients_itineraire : itineraire -> client list
	val retourner_liste_clients_plan : plan -> client list
 	val itineraire_existe : num_itineraire -> plan -> bool
        val ajouter_itineraire : itineraire -> plan -> plan
	val client_existe_itineraire : nom_client -> itineraire -> bool
	val client_existe_plan : nom_client -> plan -> bool
	val calculer_demande_totale_itineraire :  itineraire -> demande_client
	val ajouter_client : client -> itineraire ->  itineraire
        val ajouter_clients : (nom_client * demande_client) list -> itineraire -> itineraire
	val supprimer_client : nom_client ->itineraire -> itineraire
        val ajouter_itineraires : capacite_itineraire list -> (nom_client * demande_client) list list -> plan -> plan
	val retourner_numi_capresid : plan -> (num_itineraire * int)
	val afficher_itineraire  : itineraire -> unit
	val afficher_plan  : plan -> unit
end
