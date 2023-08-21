<?php
// Ceci définit l'espace de noms de la classe Search, ce qui permet de l'organiser au sein de l'application. La classe est placée dans le répertoire Classe.php
namespace App\Classe;

//Déclaration de la classe : La classe Search est déclarée.
// Cette classe un simple objet de transfert de données (DTO) 
//utilisé pour représenter les critères de recherche.
class Search
{
    // /**
    //  * @var string|null
    //  */
    // public ?string $string = '';


    //Propriété $categories : 
    //Cette propriété est de type array (spécifiquement un tableau d'entiers) ou null. 
    //Elle est initialisée avec un tableau vide.
    // Elle pourrait être utilisée pour stocker une liste d'identifiants de catégories pour filtrer les résultats de recherche.

    /**
     * @var int[]|null
     */
    public ?array $categories = [];
    // /**
    //  * @var string|null
    //  */
    // public ?string $productName = '';
    // /**
    //  * @var string|null
    //  */
    // public ?string $categoryName = '';
}
