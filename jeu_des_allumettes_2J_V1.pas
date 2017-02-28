program jeu_des_allumettes_2J_V1 (input, output);

uses crt;

const
        NbAlluMax=21; //Nombre maximum d'allumettes

type
        CaracJoueur=record  //Caracteristiques du joueur
                NumeroJoueur:integer; //Numero du joueur
                Choix:integer; //Nombre d'allumettes prises par le joueur
                AlluMain:integer; //Nombre d'allumettes dans la main du joueur
        end;

type
        Allumettes=record //Enregistrement pour le tas d'allumettes
                NbTas:integer; //Nombre d'allumettes sur le tas
        end;

type
        Scores=record //Tableau des scores
                Gagnant:integer; //Gagnant du jeu
                NbTours:integer; //Nombre de tours passes pour terminer la partie
        end;

//Creation des deux joueurs et initialisation de leur numero et de leur main
procedure SetJoueurs (var Joueur1, Joueur2:CaracJoueur);
        begin
        //Joueur 1
                Joueur1.NumeroJoueur:=1;
                Joueur1.AlluMain:=0;

        //Joueur 2
                Joueur2.NumeroJoueur:=2;
                Joueur2.AlluMain:=0;
        end;

procedure TourDeJeu (var Joueur1, Joueur2:CaracJoueur; Tour:integer;var Scoreboard:Scores);
        var
                Tas:Allumettes;

        begin

        //Initialisation du nombre d allumettes du tas d allumettes
        Tas.NbTas:=NbAlluMax;

        //Initialisation du tour
        Tour:=1;

        //Boucle de jeu
        REPEAT
                clrscr;

                //Pour le 1er joueur
                IF (Tour MOD 2<>0) THEN
                        begin
                        //Affichage du numero du joueur qui doit jouer
                        writeln('Tour du joueur : ',Joueur1.NumeroJoueur);
                        writeln;

                        //Affichage de la main des joueurs
                        writeln('Le joueur 1 a ',Joueur1.AlluMain,' allumettes');
                        writeln('Le joueur 2 a ',Joueur2.AlluMain,' allumettes');
                        writeln;

                        //Affichage du nombre d'allumettes sur le tas
                        writeln('Il y a ',Tas.NbTas,' allumettes sur le tas');
                        writeln;

                        //Entree du choix du joueur
                        writeln('Retirez 1, 2 ou 3 allumettes : ');
                        IF (Tas.NbTas>=3) THEN
                                begin
                                REPEAT
                                        readln(Joueur1.Choix);
                                UNTIL (Joueur1.Choix=1) OR (Joueur1.Choix=2) OR (Joueur1.Choix=3);
                                end
                        ELSE
                                begin
                                IF (Tas.NbTas=2) THEN
                                        begin
                                        REPEAT
                                                readln(Joueur1.Choix);
                                        UNTIL (Joueur1.Choix=1) OR (Joueur1.Choix=2);
                                        end
                                ELSE
                                        begin
                                        REPEAT
                                                readln(Joueur1.Choix);
                                        UNTIL (Joueur1.Choix=1);
                                        end;
                                end;

                        //Decrementation du tas
                        Tas.NbTas:=Tas.NbTas-Joueur1.Choix;

                        //Incrementation de la main du joueur
                        Joueur1.AlluMain:=Joueur1.AlluMain+Joueur1.Choix;

                        //Enregistre le numero du joueur gagnant
                        IF (Tas.NbTas=0) THEN
                                begin
                                Scoreboard.Gagnant:=Joueur2.NumeroJoueur;
                                end;
                        end;

                //Pour le 2eme joueur
                IF (Tour MOD 2=0) THEN
                        begin
                        //Affichage du numero du joueur qui doit jouer
                        writeln('Tour du joueur : ',Joueur2.NumeroJoueur);
                        writeln;

                        //Affichage de la main des joueurs
                        writeln('Le joueur 1 a ',Joueur1.AlluMain,' allumettes');
                        writeln('Le joueur 2 a ',Joueur2.AlluMain,' allumettes');
                        writeln;

                        //Affichage du nombre d'allumettes sur le tas
                        writeln('Il y a ',Tas.NbTas,' allumettes sur le tas');
                        writeln;

                        //Entree du choix du joueur
                        writeln('Retirez 1, 2 ou 3 allumettes : ');
                        IF (Tas.NbTas>=3) THEN
                                begin
                                REPEAT
                                        readln(Joueur2.Choix);
                                UNTIL (Joueur2.Choix=1) OR (Joueur2.Choix=2) OR (Joueur2.Choix=3);
                                end
                        ELSE
                                begin
                                IF (Tas.NbTas=2) THEN
                                        begin
                                        REPEAT
                                                readln(Joueur2.Choix);
                                        UNTIL (Joueur2.Choix=1) OR (Joueur2.Choix=2);
                                        end
                                ELSE
                                        begin
                                        REPEAT
                                                readln(Joueur2.Choix);
                                        UNTIL (Joueur2.Choix=1);
                                        end;
                                end;

                        //Decrementation du tas
                        Tas.NbTas:=Tas.NbTas-Joueur2.Choix;

                        //Incrementation de la main du joueur
                        Joueur2.AlluMain:=Joueur2.AlluMain+Joueur2.Choix;

                        //Enregistre le numero du joueur gagnant
                        IF (Tas.NbTas=0) THEN
                                begin
                                Scoreboard.Gagnant:=Joueur1.NumeroJoueur;
                                end;
                        end;

                //Incrementation du tour
                Tour:=Tour+1;

        UNTIL (Tas.NbTas=0);

        //Enregistre le nombre de tours de la partie
        Scoreboard.NbTours:=Tour;

        end;

procedure TabScores (var Scoreboard:scores);
        begin
        clrscr;
        writeln('.____________________________.');
        writeln('|      FIN DE LA PARTIE      |');
        writeln('|____________________________|');
        writeln('| Le gagnant est le joueur ', Scoreboard.Gagnant,' |');
        writeln('|____________________________|');
        writeln('| Nombre de tours joues : ', Scoreboard.NbTours,'  |');
        writeln('|____________________________|');
        end;

var
        Joueur1, Joueur2:CaracJoueur; //Variables contenant ce qui caracterise les 2 joueurs
        TasAll:Allumettes; //Variable contenant ce qui caract‚rise le tas d'allumettes
        Tour:integer; //Tour de jeu
        Scoreboard:Scores; //Tableau des scores

//Programme principal
BEGIN
        clrscr;
        writeln('Programme : jeu des allumettes');
        writeln('Appuyez sur ''entrer'' pour continuer');
        clrscr;

        //Initialisation des joueurs
        SetJoueurs(Joueur1,Joueur2);


        //Tour de jeu
        TourDeJeu(Joueur1,Joueur2,Tour,Scoreboard);

        //Tableau des scores
        TabScores(Scoreboard);

        readln;
END.
