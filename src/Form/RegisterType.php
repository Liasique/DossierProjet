<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\Email;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Constraints\NotNull;

// La classe RegisterType est utilisée pour créer un formulaire d'inscription pour les utilisateurs.
class RegisterType extends AbstractType
{
    // La méthode buildForm est utilisée pour construire le formulaire, définir les champs et leurs configurations.
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            // Champ 'firstname' pour le nom de l'utilisateur.
            ->add('firstname', TextType::class, [
                'label' => 'Votre nom',
                'required' => false,
                'attr' => [
                    'class' => 'w3-input w3-border col-md-12'
                ],
                'constraints' => [
                    new NotNull([
                        'message' => 'Veuillez entrer votre nom'
                    ]),
                    new Length([
                        'min' => 2,
                        'minMessage' => 'Votre nom doit comporter au moins {{ limit }} caractères',
                        'max' => 4096,
                    ]),
                ],
            ])
            // Champ 'lastname' pour le prénom de l'utilisateur.
            ->add('lastname', TextType::class, [
                'label' => 'Votre prénom',
                'required' => false,
                'attr' => [
                    'class' => 'w3-input w3-border col-md-12'
                ],
                'constraints' => [
                    new NotNull([
                        'message' => 'Veuillez entrer votre prénom'
                    ]),
                    new Length([
                        'min' => 2,
                        'minMessage' => 'Votre prénom doit comporter au moins {{ limit }} caractères',
                        'max' => 4096,
                    ]),
                ],
            ])
            // Champ 'email' pour l'adresse e-mail de l'utilisateur.
            ->add('email', EmailType::class, [
                'label' => 'Votre email',
                'required' => false,
                'attr' => [
                    'class' => 'w3-input w3-border col-md-12'
                ],
                'constraints' => [
                    new NotNull([
                        'message' => 'Veuillez entrer votre email'
                    ]),
                    new Email([
                        'message' => 'Veuillez entrer une adresse email valide'
                    ]),
                ],
            ])
            // Champ 'password' pour le mot de passe de l'utilisateur. Utilise le type RepeatedType pour confirmer le mot de passe.
            ->add('password', RepeatedType::class, [
                'type' => PasswordType::class,
                'invalid_message' => 'Les deux mots de passe doivent être identiques',
                'required' => false,
                'first_options' => [
                    'label' => 'Mot de passe',
                    'attr' => [
                        'placeholder' => 'Entrez votre mot de passe',
                        'class' => 'w3-input w3-border col-md-12',
                    ]
                ],
                'second_options' => [
                    'label' => 'Confirmez votre mot de passe',
                    'attr' => [
                        'placeholder' => 'Confirmez votre mot de passe',
                        'class' => 'w3-input w3-border col-md-12',
                    ]
                ],
                'constraints' => [
                    new NotNull([
                        'message' => 'Veuillez entrer un mot de passe valide'
                    ]),
                    new Length([
                        'min' => 8,
                        'minMessage' => 'Votre mot de passe doit comporter au moins {{ limit }} caractères',
                        'max' => 4096,
                    ])
                ]
            ])
            // Champ 'submit' pour soumettre le formulaire.
            ->add('submit', SubmitType::class, [
                'label' => 'S\'inscrire',
                'attr' => [
                    'class' => 'btn w3-black btn-block w-100',
                ],
            ]);
    }

    // La méthode configureOptions est utilisée pour configurer les options générales du formulaire.
    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => User::class, // La classe User est utilisée comme modèle de données pour ce formulaire.
        ]);
    }
}
