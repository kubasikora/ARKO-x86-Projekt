/*********************************************
 * Architektura komputerów
 * Projekt 2 
 * Autor: Jakub Sikora
 * Prowadzący: mgr. inż. Sławomir Niespodziany
 * *******************************************/

#include<stdio.h>
#include<allegro5/allegro.h>
#include <allegro5/allegro_image.h> // plik nagłówkowy
#include <allegro5/allegro_native_dialog.h> // plik nagłówkowy do funkcji sprawdzającej wczytanie bitmapy.

#include"arko.h"

volatile int close_button_pressed = 0;
void close_button_handler(void);

const float FPS = 60;
const int WINDOW_WIDTH = 800;
const int WINDOW_HEIGHT = 600;

int main(int argc, char* argv[]){
	ALLEGRO_DISPLAY *display = NULL;
	ALLEGRO_TIMER *tick = NULL;
	ALLEGRO_EVENT_QUEUE *event_queue = NULL;
	ALLEGRO_BITMAP *bitmap = NULL;
	ALLEGRO_LOCKED_REGION *region = NULL;

	bool redraw = true;
	unsigned char* pixelBuffer;

	Points points;
	points.num = 0;

    if(!al_init()) {
        printf("Error with allegro\n");
		return -1;
    }

    display = al_create_display(WINDOW_WIDTH, WINDOW_HEIGHT);
    if(!display){
         printf("Error with display\n");
		return -1;
    }

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

	al_set_window_title( display, "Architektura Komputerów");

	bitmap = al_create_bitmap(WINDOW_WIDTH, WINDOW_HEIGHT);

	al_init_image_addon();

	al_set_target_bitmap(bitmap);
	al_clear_to_color(al_map_rgb(255, 255, 255));

	al_set_target_backbuffer(display);
	
	al_install_mouse();

	al_register_event_source(event_queue, al_get_display_event_source(display));
	al_register_event_source(event_queue, al_get_timer_event_source(tick));
	al_register_event_source(event_queue, al_get_mouse_event_source());

	al_start_timer(tick);
	while (true)
	{
		ALLEGRO_EVENT ev;
		al_wait_for_event(event_queue, &ev);

		switch(ev.type){
			case ALLEGRO_EVENT_TIMER:
				
				break;

			case ALLEGRO_EVENT_DISPLAY_CLOSE:
				al_save_bitmap("./bitmap.bmp", bitmap);
				exit(0);

			case ALLEGRO_EVENT_MOUSE_BUTTON_DOWN:
				points.x[points.cursor]	= ev.mouse.x;
				points.y[points.cursor] = ev.mouse.y;
				points.cursor++;
				points.num++;
				
				if(points.cursor > MAX_POINTS) points.cursor = 0;
				if(points.num > MAX_POINTS) points.num = 0;

				#ifdef DEBUG
				printf("==============\n");
				for (int i = 0; i < points.num; i++){
					printf("%d: (%d, %d)\n", i, points.x[i], points.y[i]);
				}
				#endif //DEBUG
				redraw = true;
				break;

			default:
				break;
		}

		if (redraw && al_is_event_queue_empty(event_queue)) {
			unsigned int a;
			redraw = false;

			region = al_lock_bitmap(bitmap, ALLEGRO_PIXEL_FORMAT_ABGR_8888, ALLEGRO_LOCK_READWRITE);
			pixelBuffer = (unsigned char*) region -> data;
			pixelBuffer -= (-region->pitch * (WINDOW_HEIGHT -1));
			printf("Pitch: %d, pixelSize: %d\n", region->pitch, region->pixel_size);
			a = bezier(pixelBuffer, points.num, points.x, points.y);
			printf("%0x\n", a);
			al_unlock_bitmap(bitmap);

			al_clear_to_color(al_map_rgb(255, 255, 255));
			al_draw_bitmap(bitmap, 0, 0, 0);
			al_flip_display();
		}
	}

	return 0;
}
