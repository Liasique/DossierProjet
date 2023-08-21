<?php
// namespace App\Form; : Ceci définit l'espace de noms de la classe, ce qui permet de l'organiser au sein de l'application.
namespace App\Form;
// Les use suivants importent différentes classes et interfaces nécessaires pour construire et configurer le formulaire.
use App\Classe\Search;
use App\Entity\Category;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

//Déclaration de la classe :
class SearchType extends AbstractType
//La classe SearchType est déclarée et étend AbstractType, 
//ce qui signifie qu'elle hérite des fonctionnalités de base pour créer un formulaire dans Symfony.
{
    // Cette méthode est utilisée pour construire le formulaire.
    // Elle prend deux arguments : $builder, qui est utilisé pour ajouter des champs au formulaire, 
    //et $options, qui contient des options supplémentaires.
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            // Le champ categories est un champ de type EntityType, 
            //ce qui signifie qu'il affichera une liste de choix basée sur une entité 
            //(dans ce cas, l'entité Category).
            ->add('categories', EntityType::class, [
                'label' => 'Chercher par marque',
                'class' => Category::class, // Classe associée au champ
                'choice_label' => 'name', // Label affiché pour chaque choix
                'multiple' => true, // Permet de sélectionner plusieurs catégories
                'expanded' => true, // Affiche les choix sous forme de boutons radio ou de cases à cocher
            ])
            // Bouton pour soumettre le formulaire
            ->add('submit', SubmitType::class, [
                'label' => 'Chercher',
                'attr' => [
                    'class' => 'btn-block w3-black w-100'
                ]
            ]);
    }

    // Cette méthode configure les options du formulaire
    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Search::class,
            // data_class est défini sur Search::class, 
            //ce qui signifie que ce formulaire est associé à la classe Search.
            // Lorsque le formulaire est soumis, les données seront automatiquement mappées à une instance de cette classe.
            'method' => 'GET', //  est défini sur 'GET', ce qui signifie que le formulaire utilisera la méthode HTTP GET lors de la soumission.
            'csrf_protection' => false // Désactivation de la protection CSRF (non recommandé pour des formulaires sensibles)
        ]);
    }

    // Cette méthode est utilisée pour définir un préfixe pour les noms des champs du formulaire.
    // En retournant une chaîne vide (''), cela garantit que les noms des champs 
    //n'auront pas de préfixe dans l'URL lors de la soumission du formulaire.
    public function getBlockPrefix(): string
    {
        return '';
    }
}
