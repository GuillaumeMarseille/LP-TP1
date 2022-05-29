(***************************************************************************)
(* Jeu d'essai - TP1 - Été 2022                                            *)
(***************************************************************************)

(* Pour changer ou obtenir le répertoire courant
Sys.getcwd ();;
Sys.chdir;;
*)

(* Pour afficher les listes avec plus de «profondeurs»:
#print_depth 1000;;
#print_length 1000;;
*)

(* On charge le fichier ml du Tp après avoir implanté
les fonctions demandées pour realiser les tests  *)

#use "TP1-E2022.ml";;

(* Résultat:
module type PLAN =
  sig
    exception Err of string
    type nom_client = string
    type demande_client = int
    type num_itineraire = int
    type capacite_itineraire = int
    type client = { nom : nom_client; demande : demande_client; }
    type itineraire = {
      num : num_itineraire;
      capacite : capacite_itineraire;
      liste_clients : client list;
    }
    type plan = Vide | Ilist of itineraire list
    val initialiser_plan : unit -> plan
    val creer_client : nom_client -> demande_client -> client
    val creer_itineraire : capacite_itineraire -> itineraire
    val retourner_liste_clients_itineraire : itineraire -> client list
    val retourner_liste_clients_plan : plan -> client list
    val itineraire_existe : num_itineraire -> plan -> bool
    val ajouter_itineraire : itineraire -> plan -> plan
    val client_existe_itineraire : nom_client -> itineraire -> bool
    val client_existe_plan : nom_client -> plan -> bool
    val calculer_demande_totale_itineraire : itineraire -> demande_client
    val ajouter_client : client -> itineraire -> itineraire
    val ajouter_clients :
      (nom_client * demande_client) list -> itineraire -> itineraire
    val supprimer_client : nom_client -> itineraire -> itineraire
    val ajouter_itineraires :
      capacite_itineraire list ->
      (nom_client * demande_client) list list -> plan -> plan
    val retourner_numi_capresid : plan -> num_itineraire * int
    val afficher_itineraire : itineraire -> unit
    val afficher_plan : plan -> unit
  end
module Plan : PLAN
*)

(* On ouvre les modules disposant de fonctions pertinentes pour nos tests *)
open Plan;;

(* On exécute maintenant les fonctions une à une *)

let p = initialiser_plan ();;

(* Résultat:
val p : Plan.plan = Vide
*)

let i = creer_itineraire 90;;
(* Résultat:
val i : Plan.itineraire = {num = 1; capacite = 90; liste_clients = []}
*)

let c1 = creer_client "c7" 10;;

(* Résultat:
val c1 : Plan.client = {nom = "c7"; demande = 10}
*)

let i = ajouter_client c1 i;;

(* Résultat:
val i : Plan.itineraire =
  {num = 1; capacite = 90; liste_clients = [{nom = "c7"; demande = 10}]}
*)

client_existe_itineraire "c7" i;;
(* Résultat:
- : bool = true
*)

client_existe_itineraire "c99" i;;
(* Résultat:
- : bool = false
*)

let i = ajouter_clients [("c14",5);("c22",12);("c3",7);("c11",4);("c23",13)] i;;

(* Résultat:
val i : Plan.itineraire =
  {num = 1; capacite = 90;
   liste_clients =
    [{nom = "c7"; demande = 10}; {nom = "c14"; demande = 5};
     {nom = "c22"; demande = 12}; {nom = "c3"; demande = 7};
     {nom = "c11"; demande = 4}; {nom = "c23"; demande = 13}]}
*)

retourner_liste_clients_itineraire i;;

(* Résultat:
- : Plan.client list =
[{nom = "c7"; demande = 10}; {nom = "c14"; demande = 5};
 {nom = "c22"; demande = 12}; {nom = "c3"; demande = 7};
 {nom = "c11"; demande = 4}; {nom = "c23"; demande = 13}]
*)

calculer_demande_totale_itineraire i;;
(* Résultat:
- : Plan.demande_client = 51
*)

let p = ajouter_itineraire i p;;

(* Résultat:
val p : Plan.plan =
  Ilist
   [{num = 1; capacite = 90;
     liste_clients =
      [{nom = "c7"; demande = 10}; {nom = "c14"; demande = 5};
       {nom = "c22"; demande = 12}; {nom = "c3"; demande = 7};
       {nom = "c11"; demande = 4}; {nom = "c23"; demande = 13}]}]
*)

let p = ajouter_itineraires [115;70;150]
                            [[("c13",8);("c1",7);("c2",3);("c10",11);("c20",5);("c19",15)];
                            [("c4",12);("c18",10);("c8",14);("c16",8)];
                            [("c6",9);("c12",3);("c17",6);("c21",8);("c5",10);("c15",4);("c9",7)]] p;;

(* Résultat:
      val p : Plan.plan =
  Ilist
   [{num = 1; capacite = 90;
     liste_clients =
      [{nom = "c7"; demande = 10}; {nom = "c14"; demande = 5};
       {nom = "c22"; demande = 12}; {nom = "c3"; demande = 7};
       {nom = "c11"; demande = 4}; {nom = "c23"; demande = 13}]};
    {num = 2; capacite = 115;
     liste_clients =
      [{nom = "c13"; demande = 8}; {nom = "c1"; demande = 7};
       {nom = "c2"; demande = 3}; {nom = "c10"; demande = 11};
       {nom = "c20"; demande = 5}; {nom = "c19"; demande = 15}]};
    {num = 3; capacite = 70;
     liste_clients =
      [{nom = "c4"; demande = 12}; {nom = "c18"; demande = 10};
       {nom = "c8"; demande = 14}; {nom = "c16"; demande = 8}]};
    {num = 4; capacite = 150;
     liste_clients =
      [{nom = "c6"; demande = 9}; {nom = "c12"; demande = 3};
       {nom = "c17"; demande = 6}; {nom = "c21"; demande = 8};
       {nom = "c5"; demande = 10}; {nom = "c15"; demande = 4};
       {nom = "c9"; demande = 7}]}]
*)

retourner_liste_clients_plan p;;

(* Résultat:
- : Plan.client list =
[{nom = "c7"; demande = 10}; {nom = "c14"; demande = 5};
 {nom = "c22"; demande = 12}; {nom = "c3"; demande = 7};
 {nom = "c11"; demande = 4}; {nom = "c23"; demande = 13};
 {nom = "c13"; demande = 8}; {nom = "c1"; demande = 7};
 {nom = "c2"; demande = 3}; {nom = "c10"; demande = 11};
 {nom = "c20"; demande = 5}; {nom = "c19"; demande = 15};
 {nom = "c4"; demande = 12}; {nom = "c18"; demande = 10};
 {nom = "c8"; demande = 14}; {nom = "c16"; demande = 8};
 {nom = "c6"; demande = 9}; {nom = "c12"; demande = 3};
 {nom = "c17"; demande = 6}; {nom = "c21"; demande = 8};
 {nom = "c5"; demande = 10}; {nom = "c15"; demande = 4};
 {nom = "c9"; demande = 7}]
*)

client_existe_plan "c5" p;;
(* Résultat:
- : bool = true
*)

client_existe_plan "c99" p;;
(* Résultat:
- : bool = false
*)

itineraire_existe 4 p;;
(* Résultat:
- : bool = true
*)

itineraire_existe 99 p;;
(* Résultat:
- : bool = false
*)

retourner_numi_capresid p;;

(* Résultat:
- : Plan.num_itineraire * int = (4, 103)
*)

afficher_itineraire i;;

(* Résultat:
Itineraire 1: c7 c14 c22 c3 c11 c23
- : unit = ()
*)

afficher_plan p;;

(* Résultat:
Itineraire 1: c7 c14 c22 c3 c11 c23
Itineraire 2: c13 c1 c2 c10 c20 c19
Itineraire 3: c4 c18 c8 c16
Itineraire 4: c6 c12 c17 c21 c5 c15 c9
Capacite residuelle la plus elevee: 103 appartenant a l'itineraire numero 4.
- : unit = ()
*)

let i = supprimer_client "c23" i;;

(* Résultat:
val i : Plan.itineraire =
  {num = 1; capacite = 90;
   liste_clients =
    [{nom = "c7"; demande = 10}; {nom = "c14"; demande = 5};
     {nom = "c22"; demande = 12}; {nom = "c3"; demande = 7};
     {nom = "c11"; demande = 4}]}
*)

afficher_itineraire i;;

(* Résultat:
Itineraire 1: c7 c14 c22 c3 c11
- : unit = ()
*)

(***************************************)
(* Verification des messages d'erreurs *)
(***************************************)

try
    ignore(ajouter_itineraire i p)
with
  Err s -> print_endline s;;

(* Résultat:
Cet itineraire existe deja.
- : unit = ()
*)

try
    ignore(ajouter_client c1 i)
with
  Err s -> print_endline s;;

(* Résultat:
Ce client existe deja.
- : unit = ()
*)

try
    ignore(ajouter_client (creer_client "c77" 500) i)
with
  Err s -> print_endline s;;

(* Résultat:
La capacite de cet itinéraire ne permet pas d'ajouter ce client.
- : unit = ()
*)

try
    ignore(supprimer_client "c99" i)
with
  Err s -> print_endline s;;

(* Résultat:
Le client n'existe pas.
- : unit = ()
*)

try
    ignore(retourner_numi_capresid (initialiser_plan ()))
with
  Err s -> print_endline s;;

(* Résultat:
Le plan est vide.
- : unit = ()
*)

try
    afficher_plan (initialiser_plan ())
with
  Err s -> print_endline s;;

(* Résultat:
Le plan est vide.
- : unit = ()
*)
