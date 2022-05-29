(*******************************************************************)
(* Langages de Programmation: IFT 3000 �T� 2022                    *)
(* TP1. Date limite: Mercredi 08 juin � 17h00                      *)
(* Manipulation d'un plan en utilisant des                         *)
(* listes et des enregistrements.                                  *)
(*******************************************************************)
(* �tudiant(e):                                                    *)
(* NOM: _______________________ PR�NOM:___________________________ *)
(* MATRICULE: _________________ PROGRAMME: _______________________ *)
(*                                                                 *)
(*******************************************************************)

(* Charger la signature PLAN *)
#use "TP1-SIG-E2022.mli";;

(*******************************************************************)
(* Implantation du plan en utilisant les listes                    *)
(*******************************************************************)

module Plan : PLAN  = struct

   open List

(* *****************************************************************)
(* D�clarations d'exceptions et de types                           *)
(* *****************************************************************)

   exception  Err of string

   type nom_client = string
   type demande_client = int
   type num_itineraire = int
   type capacite_itineraire = int
   type client =  {nom : nom_client; demande : demande_client}
   type itineraire = {num : num_itineraire;
                      capacite : capacite_itineraire; liste_clients : client list}
   type plan = Vide | Ilist of itineraire list

   let num = ref 0
   let get_num () = (num:=!num+1);!num

(******************************************************************)
(* Fonctions fournies (vous pouvez en ajouter au besoin ...)      *)
(* ****************************************************************)

   (* initialiser_plan : unit -> plan  *)
   let initialiser_plan () = Vide

   (* creer_client: nom_client -> demande_client -> client *)
   let creer_client (n: nom_client) (d: demande_client) =  {nom = n; demande = d}

   (* creer_itineraire: capacite_itineraire -> itineraire  *)
   let creer_itineraire (cap: capacite_itineraire)  =
       {num = get_num (); capacite = cap; liste_clients = []}

   (* retourner_liste_clients_itineraire: itineraire -> client list  *)
   let retourner_liste_clients_itineraire (i: itineraire) = (i.liste_clients)

   (* retourner_liste_clients_plan: plan -> client list *)
   let retourner_liste_clients_plan (p: plan) = match p with
       | Vide -> []
       | Ilist l  -> let t = map (fun i -> retourner_liste_clients_itineraire i) l in
                        let r = concat t in r

   (* itineraire_existe: num_itineraire -> plan -> bool *)
   let itineraire_existe (indice: num_itineraire) (p: plan) = match p with
       | Vide -> false
       | Ilist l -> exists (fun i -> (i.num = indice)) l

(******************************************************************)
(* Fonctions � implanter				          *)
(* ****************************************************************)

   (* -- � IMPLANTER (7 PTS) --------------------------------------------*)
   (* @M�thode : ajouter_itineraire: itineraire -> plan -> plan          *)
   (* @Description : Retourne un plan contenant un nouvel itin�raire.    *)
   (* @Exception: lance une exception (Err) si l�itin�raire existe d�j�  *)

   let  ajouter_itineraire (i: itineraire) (p: plan) =
       (* A corriger : il est conseill� d'utilsier le filtrage *)
       Vide

   (* -- � IMPLANTER (6 PTS) -------------------------------------------------*)
   (* @M�thode : client_existe_itineraire: nom_client -> itineraire -> bool   *)
   (* @Description : D�termine si un client existe dans un itin�raire         *)

   let client_existe_itineraire (n: nom_client) (i: itineraire) =
       (* A corriger *)
       true

   (* -- � IMPLANTER (7 PTS) -----------------------------------------*)
   (* @M�thode : client_existe_plan: nom_client -> plan -> bool       *)
   (* @Description : D�termine si un client existe dans un plan       *)

   let client_existe_plan (n: nom_client) (p:  plan) =
       (* A corriger : il est conseill� d'utilsier le filtrage *)
       true

   (* -- � IMPLANTER (8 PTS) ---------------------------------------------------------*)
   (* @M�thode : calculer_demande_totale_itineraire : itineraire -> demande_client    *)
   (* @Description : Calcul la demande totale des clients appartenant � un itin�raire *)

   let calculer_demande_totale_itineraire (i: itineraire) =
       (* A corriger *)
       0

   (* -- � IMPLANTER (12 PTS) ------------------------------------------------------------*)
   (* @M�thode : ajouter_client: client -> itineraire -> itineraire                       *)
   (* @Description : Retourne un itineraire contenant un nouveau client                   *)
   (* @Exception: lance une exception (Err) si la capacit� du v�hicule n'est pas correct  *)
   (* @Exception: lance une exception (Err) si le client existe d�j�                      *)

   let ajouter_client (c: client) (i: itineraire) =
       (* A corriger *)
       {num = 0; capacite = 0; liste_clients = []}

   (* -- � IMPLANTER (8 PTS) ----------------------------------------------------------------------*)
   (* @M�thode : ajouter_clients: (nom_client * demande_client) list -> itineraire -> itineraire   *)
   (* @Description : Ajoute plusieurs clients dans un itin�raire selon les informations re�ues     *)

   let ajouter_clients (lclt: (nom_client * demande_client) list) (i: itineraire) =
       (* A corriger *)
       {num = 0; capacite = 0; liste_clients = []}

   (* -- � IMPLANTER (8 PTS) ----------------------------------------------*)
   (* @M�thode : supprimer_client: nom_client -> itineraire -> itineraire  *)
   (* @Description : Supprime un client d'un itineraire                    *)
   (* @Exception: lance une exception (Err) si le client n'existe pas      *)

    let supprimer_client (n: nom_client) (i:itineraire) =
       (* A corriger *)
       {num = 0; capacite = 0; liste_clients = []}

   (* -- � IMPLANTER (8 PTS) ----------------------------------------------------------------------*)
   (* @M�thode : ajouter_itineraires: capacite_itineraire list ->                                  *)
   (*                                   (nom_client * demande_client) list list -> plan -> plan    *)
   (* @Description : Ajoute dans un plan plusieurs itin�raires contenant leurs clients respectifs  *)

   let  ajouter_itineraires (lcap: capacite_itineraire list) (litn: (nom_client * demande_client) list list) (p: plan) =
       (* A corriger *)
       Vide

   (* -- � IMPLANTER (12 PTS) --------------------------------------------------------------------------------*)
   (* @M�thode : retourner_numi_capresid: plan -> (num_itineraire * int)                                      *)
   (* @Description : Retourne le num�ro de l'itin�raire et sa capacit� r�siduelle la plus �lev�e dans un plan *)
   (* @Exception: lance une exception (Err) si le plan est vide                                               *)

   let retourner_numi_capresid  (p: plan) =
       (* A corriger : il est conseill� d'utilsier le filtrage *)
       (0,0)

   (* -- � IMPLANTER (7 PTS) -----------------------------------------------------*)
   (* @M�thode : afficher_itineraire: itineraire -> unit                          *)
   (* @Description : Affiche tous les noms de clients appartenant � un itin�raire *)

   let afficher_itineraire (i: itineraire) =
       (* A corriger *)
       ()

   (* -- � IMPLANTER (7 PTS) ------------------------------------------------------------------------*)
   (* @M�thode : afficher_plan: plan -> unit                                                         *)
   (* @Description : Affiche les noms des clients d'un plan et la capacit� r�siduelle la plus �lev�e *)
   (* @Exception: lance une exception (Err) si le plan est vide                                      *)

   let afficher_plan (p: plan) =
       (* A corriger : il est conseill� d'utilsier le filtrage *)
       ()

end



