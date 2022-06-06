(*******************************************************************)
(* Langages de Programmation: IFT 3000 �T� 2022                    *)
(* TP1. Date limite: Mercredi 08 juin � 17h00                      *)
(* Manipulation d'un plan en utilisant des                         *)
(* listes et des enregistrements.                                  *)
(*******************************************************************)
(* �tudiant(e):                                                    *)
(* NOM: Marseille               PR�NOM: Guillaume                  *)
(* MATRICULE: 536 857 347       PROGRAMME: Bac Informatique        *)
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
   
   (*-----------------------------Mes fonctions-----------------------------------*)
   
   (* clientExisteListe: nom_client -> client list -> bool *)
   let rec clientExisteListe (nom: nom_client) (liste: client list) = match liste with
       |[] -> false
       |e::r -> (nom = e.nom) || (clientExisteListe nom r)

   (* majListeItineraire : itineraire -> client list -> itineraire *)
   let majListeItineraire i nl =
     { i with liste_clients = nl }
   

         


(******************************************************************)
(* Fonctions � implanter				          *)
(* ****************************************************************)

   (* -- � IMPLANTER (7 PTS) --------------------------------------------*)
   (* @M�thode : ajouter_itineraire: itineraire -> plan -> plan          *)
   (* @Description : Retourne un plan contenant un nouvel itin�raire.    *)
   (* @Exception: lance une exception (Err) si l�itin�raire existe d�j�  *)

   let  ajouter_itineraire (i: itineraire) (p: plan) =
     if itineraire_existe i.num p then raise (Err "Itineraire existe deja")
     else  match p with
     | Vide -> Ilist [i]
     | Ilist l -> Ilist( l@[i]);;
   
   (* -- � IMPLANTER (6 PTS) -------------------------------------------------*)
   (* @M�thode : client_existe_itineraire: nom_client -> itineraire -> bool   *)
   (* @Description : D�termine si un client existe dans un itin�raire         *)

   let client_existe_itineraire (n: nom_client) (i: itineraire) =
   clientExisteListe n i.liste_clients;;
   
   (* -- � IMPLANTER (7 PTS) -----------------------------------------*)
   (* @M�thode : client_existe_plan: nom_client -> plan -> bool       *)
   (* @Description : D�termine si un client existe dans un plan       *)

   let client_existe_plan (n: nom_client) (p:  plan) =
     let lc = retourner_liste_clients_plan p in  clientExisteListe n lc;;

   (* -- � IMPLANTER (8 PTS) ---------------------------------------------------------*)
   (* @M�thode : calculer_demande_totale_itineraire : itineraire -> demande_client    *)
   (* @Description : Calcul la demande totale des clients appartenant � un itin�raire *)
   let calculer_demande_totale_itineraire (i: itineraire) =
     let lc = retourner_liste_clients_itineraire i in
       let ld = map (fun x -> x.demande) lc in
         let t: demande_client = fold_right (+) ld 0 in
           t;;

   (* -- � IMPLANTER (12 PTS) ------------------------------------------------------------*)
   (* @M�thode : ajouter_client: client -> itineraire -> itineraire                       *)
   (* @Description : Retourne un itineraire contenant un nouveau client                   *)
   (* @Exception: lance une exception (Err) si la capacit� du v�hicule n'est pas correct  *)
   (* @Exception: lance une exception (Err) si le client existe d�j�                      *)

   let ajouter_client (c: client) (i: itineraire) =
   	let lc = retourner_liste_clients_itineraire i in
   	    if clientExisteListe c.nom lc then raise (Err "Client existe deja")
   	    else let nl = lc@[c] in
                let ni = majListeItineraire i nl in
                if ni.capacite < (calculer_demande_totale_itineraire ni) then raise (Err "Capacite insuffisante")
                else ni;; 
                    
                                         
   (* -- � IMPLANTER (8 PTS) ----------------------------------------------------------------------*)
   (* @M�thode : ajouter_clients: (nom_client * demande_client) list -> itineraire -> itineraire   *)
   (* @Description : Ajoute plusieurs clients dans un itin�raire selon les informations re�ues     *)

    let ajouter_clients (lclt: (nom_client * demande_client) list) (i: itineraire) =
      let lcr = map (fun (x,y) -> {nom = x; demande = y}) lclt in
       let rec ajouterClientsRec lcr it = match lcr with
         | [] -> it
         | e::r -> (ajouterClientsRec r (ajouter_client e it)) in
            ajouterClientsRec lcr i;;


   (* -- � IMPLANTER (8 PTS) ----------------------------------------------*)
   (* @M�thode : supprimer_client: nom_client -> itineraire -> itineraire  *)
   (* @Description : Supprime un client d'un itineraire                    *)
   (* @Exception: lance une exception (Err) si le client n'existe pas      *)

    let supprimer_client (n: nom_client) (i:itineraire) =
      let lc = retourner_liste_clients_itineraire i in
      	if clientExisteListe n lc then 
      	   let listeAjours = fold_right (fun c nlc-> if (c.nom = n) then nlc else c::nlc) lc [] in
      	   majListeItineraire i listeAjours
      	else raise (Err "Client inexistant");;


   (* -- � IMPLANTER (8 PTS) ----------------------------------------------------------------------*)
   (* @M�thode : ajouter_itineraires: capacite_itineraire list ->                                  *)
   (*                                   (nom_client * demande_client) list list -> plan -> plan    *)
   (* @Description : Ajoute dans un plan plusieurs itin�raires contenant leurs clients respectifs  *)

    let  ajouter_itineraires (lcap: capacite_itineraire list)
                             (litn: (nom_client * demande_client) list list)
                             (p: plan) =  let listeItineraires =
                                            fold_left2 (fun liste cap itn ->
                                                liste@[(let it = creer_itineraire cap
                                                 in ajouter_clients itn it)]) [] lcap litn in 
           let rec ajouterItineraires lst pln = match lst with
             | [] -> pln
             | e::r -> ajouterItineraires r (ajouter_itineraire e pln) in
           ajouterItineraires listeItineraires p;;
    
   (* -- � IMPLANTER (12 PTS) --------------------------------------------------------------------------------*)
   (* @M�thode : retourner_numi_capresid: plan -> (num_itineraire * int)                                      *)
   (* @Description : Retourne le num�ro de l'itin�raire et sa capacit� r�siduelle la plus �lev�e dans un plan *)
   (* @Exception: lance une exception (Err) si le plan est vide                                               *)

    let retourner_numi_capresid  (p: plan) =
      let trouverPairMax (p: plan) =
        let calculerResiduelle (i: itineraire) = 
         i.capacite - calculer_demande_totale_itineraire i in
           let x = ref (-1, min_int) in  match p with
            | Vide -> raise (Err "Plan vide")
            | Ilist l -> let rec trouverMaxResi (lstIt: itineraire list) =
                    match lstIt with 
                    | [] -> !x
                    | e::r -> let cr = calculerResiduelle e in
                       if (cr > snd !x) then x := (e.num, cr); trouverMaxResi r in
                           trouverMaxResi l in
                             let ans: (num_itineraire * int) = trouverPairMax p in ans;;
    

   (* -- � IMPLANTER (7 PTS) -----------------------------------------------------*)
   (* @M�thode : afficher_itineraire: itineraire -> unit                          *)
   (* @Description : Affiche tous les noms de clients appartenant � un itin�raire *)


    let afficher_itineraire (i: itineraire) =
      print_endline "test";;

    
   (* -- � IMPLANTER (7 PTS) ------------------------------------------------------------------------*)
   (* @M�thode : afficher_plan: plan -> unit                                                         *)
   (* @Description : Affiche les noms des clients d'un plan et la capacit� r�siduelle la plus �lev�e *)
   (* @Exception: lance une exception (Err) si le plan est vide                                      *)

   let afficher_plan (p: plan) =
       (* A corriger : il est conseill� d'utilsier le filtrage *)
       ()

end




