/*********************************************
 * Architektura komputerów
 * Projekt 2 
 * Autor: Jakub Sikora
 * Prowadzący: mgr. inż. Sławomir Niespodziany
 * *******************************************/

#include<stdio.h>
#include<allegro5/allegro.h>
#include<allegro5/allegro_native_dialog.h>

#include"arko.h"

volatile int close_button_pressed = 0;
void close_button_handler(void);

const float FPS = 60;

int main(int argc, char* argv[]){
	if(argc < 2){
		printf("Argument missing!\n");
		return 0;
	}

	ALLEGRO_DISPLAY *display = NULL;
	ALLEGRO_TIMER *tick = NULL;
	
	bool redraw = true;

    if(!al_init()) {
        printf("Error with allegro\n");
		return -1;
    }

    display = al_create_display(640, 480);
    if(!display){
         printf("Error with display\n");
		return -1;
    }

	ALLEGRO_EVENT_QUEUE *event_queue = NULL;

	event_queue = al_create_event_queue();
	if (!event_queue){
		printf("Error with event queue\n");
		return -1;
	}

	tick = al_create_timer(1.0/ FPS);
	if (!tick){
		printf("Error with timer \n");
		return -1;
	}

	al_install_mouse();

	al_register_event_source(event_queue, al_get_display_event_source(display));
	al_register_event_source(event_queue, al_get_timer_event_source(tick));
	al_register_event_source(event_queue, al_get_mouse_event_source());
	
	int i = 0;
	int rising = 1;
	al_start_timer(tick);
	while (true)
	{
		//handle input and timer
		ALLEGRO_EVENT ev;
		al_wait_for_event(event_queue, &ev);


		switch(ev.type){
			case ALLEGRO_EVENT_TIMER:
				redraw = true;
				break;
			case ALLEGRO_EVENT_DISPLAY_CLOSE:
				exit(0);
			case ALLEGRO_EVENT_MOUSE_BUTTON_DOWN:
				//printf("mouse x: %d, mouse y: %d", ev.mouse.x, ev.mouse.y);		
				if(rising) i+=50;
				else i-=50;
				break;
			default:
				break;
		}

		if (redraw && al_is_event_queue_empty(event_queue)) {
			//FPS independant functions go here
			redraw = false;
			if(i >= 255){
				rising = 0;
				i = 255;
			} 
			if(i <= 0) {
				i = 0;
				rising = 1;
			}
 			if(rising) ++i;
			else --i;
			al_clear_to_color(al_map_rgb(255, 255, i)); 
			al_flip_display();
		}
	}

/*
    al_clear_to_color(al_map_rgb(0xFF,0xFF,0xFF));
    al_flip_display();
*/
      

	
	return 0;
}


void close_button_handler(void){
	 	close_button_pressed = 1;
}
