<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mercure\HubInterface;
use Symfony\Component\Mercure\Update;
use Symfony\Component\Routing\Annotation\Route;

class ChatController extends AbstractController {
    
    /**
     * @Route("/chat", name="chat")
     */
    public function index(Request $request, HubInterface $mercure): Response {
        $form = $this->createFormBuilder()
            ->add('message', TextType::class, ['attr' => ['autocomplete' => 'off']])
            ->add('send', SubmitType::class)
            ->getForm();

        $emptyForm = clone $form; // Used to display an empty form after a POST request
        $form->handleRequest($request);

        $iHaveAmessage = "";
        
        if ($form->isSubmitted() && $form->isValid()) {
            $data = $form->getData();
            
            try {
                // The HTML update is pushed to the client using Mercure
                $mercure->publish(new Update(
                    'chat',
                    $this->renderView('chat/message.stream.html.twig', ['message' => $data['message']])
                ));
            } catch (\Exception $e) {
                $iHaveAmessage = "Ça marche pas ! <br />".
                    $e->getCode(). ": " . $e->getMessage() . "<br />" 
//                    "<pre>". $e->getTraceAsString() ."</pre><br/>" .
//                    "<pre>". var_export($e, true) ."</pre><br/>"
                ;
                
            }
            
            $form = $emptyForm;
        }
        
        return $this->render('chat/index.html.twig', [
                'form' => $form->createView(),
                'iHaveAmessage' => $iHaveAmessage,
            ]
        );
    }
}
