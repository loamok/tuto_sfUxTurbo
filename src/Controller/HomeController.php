<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController {
    
    /**
     * @Route("/", name="home")
     */
    public function index(): Response {
        return $this->render('home/index.html.twig', [
            'controller_name' => 'HomeController',
        ]);
    }
    
    /**
     * @Route("/plop", name="home_plop")
     */
    public function plop(): Response {
        return $this->render('home/plop.html.twig', [
            'tag' => 'Plop !',
        ]);
    }
}
