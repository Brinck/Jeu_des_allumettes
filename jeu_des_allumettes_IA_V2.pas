program jeu_des_allumettes_IA_V2 (input, output);

uses crt;

const
        NbAlluMax=16; //Nombre maximum d'allumettes

type
        Allumettes=record //Enregistrement pour le tas d'allumettes
                NbTas:integer; //Nombre d'allumettes sur le tas
                Ligne:integer; //Numero de la ligne d'allumettes
                NbLigne:integer; //Nombre d'allumettes sur la ligne
        end;

type
        CaracJoueur=record  //Caracteristiques du joueur
                NumeroJoueur:integer; //Numero du joueur
                Choix:integer; //Nombre d'allumettes prises par le joueur
                AlluMain:integer; //Nombre d'allumettes dans la main du joueur
                ChoixLigne:integer; //Le choix de la ligne a laquelle on retire des allumettes
        end;

type
        Scores=record //Tableau des scores
                Gagnant:integer; //Gagnant du jeu
                NbTours:integer; //Nombre de tours passes pour terminer la partie
        end;

type
        TableauLignes=record //Tableau de lignes
                Tab1D:Array [1..4] of Allumettes; //Tableau 1 dim d'allumettes
        end;

//Creation des lignes
procedure CreatLignes (var L1,L2,L3,L4:Allumettes);
        begin
        //Ligne1
        L1.NbLigne:=1;
        L1.Ligne:=1;

        //Ligne2
        L2.NbLigne:=3;
        L2.Ligne:=2;

        //Ligne3
        L3.NbLigne:=5;
        L3.Ligne:=3;

        //Ligne4
        L4.NbLigne:=7;
        L4.Ligne:=4;
        end;

//Creation tableau de lignes
procedure SetTabLignes (var TabLignes:TableauLignes;var L1,L2,L3,L4:Allumettes);
        begin
        TabLignes.Tab1D[1]:=L1;
        TabLignes.Tab1D[2]:=L2;
        TabLignes.Tab1D[3]:=L3;
        TabLignes.Tab1D[4]:=L4;
        end;

//Affichage de la pyramide
procedure Pyramide (var L1,L2,L3,L4:Allumettes; var TabLignes:TableauLignes);
        var
                i:integer;

        begin

        //Ligne1
        IF (TabLignes.Tab1D[1].NbLigne>0) THEN
                begin
                FOR i:=1 TO TabLignes.Tab1D[1].NbLigne DO
                        begin
                        GoToXY(39+i,1);
                        write('X');
                        end;
                end;

        //Ligne2
        IF (TabLignes.Tab1D[2].NbLigne>0) THEN
                begin
                FOR i:=1 TO TabLignes.Tab1D[2].NbLigne DO
                        begin
                        GoToXY(39+i,2);
                        write('X');
                        end;
                end;

        //Ligne3
        IF (TabLignes.Tab1D[3].NbLigne>0) THEN
                begin
                FOR i:=1 TO TabLignes.Tab1D[3].NbLigne DO
                        begin
                        GoToXY(39+i,3);
                        write('X');
                        end;
                end;

        //Ligne4
        IF (TabLignes.Tab1D[4].NbLigne>0) THEN
                begin
                FOR i:=1 TO TabLignes.Tab1D[4].NbLigne DO
                        begin
                        GoToXY(39+i,4);
                        write('X');
                        end;
                end;
        writeln;
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

//Tour de jeu
procedure TourDeJeu (var Joueur1, Joueur2:CaracJoueur; Tour:integer;var Scoreboard:Scores;var L1,L2,L3,L4:Allumettes;var TabLignes:TableauLignes);
        var
                Tas:Allumettes; //Tas d'allumettes
                i:integer;

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
                        //Affichage de la main des joueurs
                        writeln('Le joueur 1 a ',Joueur1.AlluMain,' allumettes');
                        writeln('Le joueur 2 a ',Joueur2.AlluMain,' allumettes');
                        writeln;

                        //Affichage du nombre d'allumettes sur le tas
                        writeln('Il y a ',Tas.NbTas,' allumettes sur le tas');
                        writeln;

                        Pyramide(L1,L2,L3,L4,TabLignes);

                        //Entree du choix de la ligne
                        writeln('Choisissez la ligne');

                        REPEAT
                                REPEAT
                                        readln(Joueur1.ChoixLigne);
                                UNTIL (Joueur1.ChoixLigne>=1) AND (Joueur1.ChoixLigne<=4);
                                i:=Joueur1.ChoixLigne;
                        UNTIL (TabLignes.Tab1D[i].NbLigne<>0);

                        //Entree du choix du nombre
                        writeln('Retirez 1, 2 ou 3 allumettes : ');
                        IF (TabLignes.Tab1D[i].NbLigne>=3) THEN
                                begin
                                REPEAT
                                        readln(Joueur1.Choix);
                                UNTIL (Joueur1.Choix=1) OR (Joueur1.Choix=2) OR (Joueur1.Choix=3);
                                end
                        ELSE
                                begin
                                IF (TabLignes.Tab1D[i].NbLigne=2) THEN
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
                        TabLignes.Tab1D[i].NbLigne:=TabLignes.Tab1D[i].NbLigne-Joueur1.Choix;

                        //Incrementation de la main du joueur
                        Joueur1.AlluMain:=Joueur1.AlluMain+Joueur1.Choix;

                        //Enregistre le numero du joueur gagnant
                        IF (Tas.NbTas=0) THEN
                                begin
                                Scoreboard.Gagnant:=Joueur2.NumeroJoueur;
                                end;
                        end;

                //Pour l IA
                IF (Tour MOD 2=0) THEN
                        begin
                        //IA Lignes
                        REPEAT
                                REPEAT
                                        Randomize;
                                        Joueur2.ChoixLigne:=Random(4)+1;
                                UNTIL (Joueur2.ChoixLigne>=1) AND (Joueur2.ChoixLigne<=4);
                                i:=Joueur2.ChoixLigne;
                        UNTIL (TabLignes.Tab1D[i].NbLigne<>0);

                        //IA Nombre allumettes
                        IF (TabLignes.Tab1D[i].NbLigne=2) OR (TabLignes.Tab1D[i].NbLigne=1) THEN //S'il reste 2 allumettes ou 1
                                begin
                                Joueur2.Choix:=1;//L IA enleve 1 allumette
                                end
                        ELSE
                                begin
                                IF (TabLignes.Tab1D[i].NbLigne=3) THEN //Si il reste 3 allumettes
                                        begin
                                        Joueur2.Choix:=2; //L IA enleve 2 allumettes
                                        end
                                ELSE
                                        begin
                                        //Sinon l IA enleve autant d'allumettes que necessaire pour qu il reste un nombre d allumettes multiple de 5
                                        Joueur2.Choix:=1;
                                        WHILE (Joueur2.Choix<3) AND ((Tas.NbTas-Joueur2.Choix) MOD 5<>0) DO
                                                begin
                                                Joueur2.Choix:=Joueur2.Choix+1;
                                                end;
                                        end;
                                end;

                        //Decrementation du tas
                        Tas.NbTas:=Tas.NbTas-Joueur2.Choix;
                        TabLignes.Tab1D[i].NbLigne:=TabLignes.Tab1D[i].NbLigne-Joueur2.Choix;

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

//Tableau des scores
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
        L1,L2,L3,L4:Allumettes; //Lignes de la pyramide
        TabLignes:TableauLignes; //Tableau de lignes

//Programme principal
BEGIN
        clrscr;
        writeln('Programme : jeu des allumettes');
        writeln('Appuyez sur ''entrer'' pour continuer');
        clrscr;

        //Creation des lignes
        CreatLignes(L1,L2,L3,L4);

        //Creation du tableau des lignes
        SetTabLignes(TabLignes,L1,L2,L3,L4);

        //Initialisation des joueurs
        SetJoueurs(Joueur1,Joueur2);

        //Tour de jeu
        TourDeJeu(Joueur1,Joueur2,Tour,Scoreboard,L1,L2,L3,L4,TabLignes);

        //Tableau des scores
        TabScores(Scoreboard);

        readln;
END.

