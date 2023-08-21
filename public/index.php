<?php
//Importation de la classe : 
//Ceci importe la classe Kernel depuis le namespace App. 
//La classe Kernel est généralement le cœur de l'application Symfony et gère les requêtes entrantes.
use App\Kernel;


//Chargement automatique : 
//Cette ligne charge le fichier autoload_runtime.php depuis le répertoire vendor. 
//Ce fichier est responsable de l'auto-chargement des classes dans une application Symfony. 
//L'auto-chargement permet d'inclure automatiquement les fichiers nécessaires lorsqu'une classe est utilisée.
require_once dirname(__DIR__) . '/vendor/autoload_runtime.php';

//Déclaration de la fonction anonyme : 
//Une fonction anonyme (ou fermeture) est déclarée. 
//Cette fonction accepte un argument $context qui est un tableau. 
//Cette fonction sera probablement utilisée comme une usine pour créer une instance du noyau de l'application.
return function (array $context) {
    //Création et retour du Kernel : 
    //À l'intérieur de la fonction, une nouvelle instance de la classe Kernel est créée et renvoyée. 
    //Le constructeur de Kernel accepte deux arguments :
    //$context['APP_ENV'] : C'est  l'environnement de l'application (par exemple, dev, prod, test, etc.).
    //(bool) $context['APP_DEBUG'] : 
    //C'est un indicateur pour savoir si le mode de débogage est activé ou non. 
    //Il est casté en booléen pour s'assurer qu'il est soit true soit false.

    return new Kernel($context['APP_ENV'], (bool) $context['APP_DEBUG']);
};
