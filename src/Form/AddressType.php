<?php

namespace App\Form;

use App\Entity\Address;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CountryType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\Length;

// Classe représentant le formulaire d'adresse
class AddressType extends AbstractType
{
    // Cette méthode construit le formulaire
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            // Champ pour le nom de l'adresse
            ->add('name', TextType::class, [
                'label' => 'Quel nom voulez-vous donner à cette adresse ?',
            ])
            // Champ pour le prénom
            ->add('firstname', TextType::class, [
                'label' => 'Votre nom',
            ])
            // Champ pour le nom de famille
            ->add('lastname', TextType::class, [
                'label' => 'Votre prénom',
            ])
            // Champ pour le nom de la société (optionnel)
            ->add('company', TextType::class, [
                'label' => 'Votre société (facultatif)',
                'help' => 'Votre société pour les adresses dans le cadre de votre activité professionnelle',
                'required' => false
            ])
            // Champ pour l'adresse
            ->add('address', TextType::class, [
                'label' => 'Votre adresse',
            ])
            // Champ pour le code postal
            ->add('postal', TextType::class, [
                'label' => 'Votre code postal',
            ])
            // Champ pour la ville
            ->add('city', TextType::class, [
                'label' => 'Ville',
            ])
            // Champ pour le pays avec la France comme choix préféré
            ->add('country', CountryType::class, [
                'label' => 'Pays',
                'preferred_choices' => ['FR'],
            ])
            // Champ pour le numéro de téléphone avec validation de la longueur
            ->add('phone', TelType::class, [
                'label' => 'Votre numéro de téléphone',
                'help' => 'Votre numéro de téléphone pour les livraisons',
                'constraints' => new Length([
                    'min' => 10,
                    'max' => 10,
                    'exactMessage' => 'Votre numéro de téléphone doit comporter {{ limit }} chiffres',
                ]),
            ])
            // Bouton de soumission du formulaire
            ->add('submit', SubmitType::class, [
                'label' => 'Valider',
                'attr' => [
                    'class' => 'w3-btn w3-block w3-black'
                ]
            ]);
    }

    // Cette méthode configure les options du formulaire
    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Address::class, // Classe de données associée au formulaire
        ]);
    }
}
