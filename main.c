/*********************************************
 * Architektura komputerów
 * Projekt 2 
 * Autor: Jakub Sikora
 * Prowadzący: mgr. inż. Sławomir Niespodziany
 * *******************************************/

#include<stdio.h>
#include<allegro5/allegro.h>
#include <allegro5/allegro_image.h> 
#include <allegro5/allegro_native_dialog.h> 

#include"arko.h"

const int WINDOW_WIDTH = 800;
const int WINDOW_HEIGHT = 600;

void drawBezierCurve(ALLEGRO_BITMAP* bitmap, ALLEGRO_DISPLAY* display, Points* points, int width, int height);
void initializeAllegro();

int main(int argc, char* argv[]){
	ALLEGRO_DISPLAY *display = NULL;
	ALLEGRO_EVENT_QUEUE *event_queue = NULL;
	ALLEGRO_BITMAP *bitmap = NULL;
	
	bool redraw = true;
	Points points;
	points.num = 0;

	initializeAllegro();

	display = al_create_display(WINDOW_WIDTH, WINDOW_HEIGHT);
    if(!display){
        printf("Error with display\n");
		exit(-1);
    }

	event_queue = al_create_event_queue();
	if (!event_queue){
		printf("Error with event queue\n");
		exit(-1);
	}

	al_set_window_title(display, "Architektura Komputerów");
	bitmap = al_create_bitmap(WINDOW_WIDTH, WINDOW_HEIGHT);

	al_set_target_bitmap(bitmap);
	al_clear_to_color(al_map_rgb(255, 255, 255));
	al_set_target_backbuffer(display);

	al_register_event_source(event_queue, al_get_display_event_source(display));
	al_register_event_source(event_queue, al_get_mouse_event_source());
	
	while (true)
	{
		ALLEGRO_EVENT ev;
		al_wait_for_event(event_queue, &ev);

		switch(ev.type){
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
				redraw = true;
				break;

			default:
				break;
		}

		if (redraw && al_is_event_queue_empty(event_queue)) {
			redraw = false;

			drawBezierCurve(bitmap, display, &points, WINDOW_WIDTH, WINDOW_HEIGHT);
			al_set_target_bitmap(bitmap);
			al_clear_to_color(al_map_rgb(255, 255, 255));
			al_set_target_backbuffer(display);
			al_draw_bitmap(bitmap, 0, 0, 0);
			al_flip_display();
		}
	}

	return 0;
}

void drawBezierCurve(ALLEGRO_BITMAP* bitmap, ALLEGRO_DISPLAY* display, Points* points, int width, int height){
	unsigned char* pixelBuffer;
	unsigned char* ret;
	ALLEGRO_LOCKED_REGION *region = NULL;

	al_set_target_bitmap(bitmap);
	al_clear_to_color(al_map_rgb(255, 255, 255));
	al_set_target_backbuffer(display);

	region = al_lock_bitmap(bitmap, ALLEGRO_PIXEL_FORMAT_ABGR_8888, ALLEGRO_LOCK_READWRITE);
	pixelBuffer = (unsigned char*) region -> data;
	pixelBuffer -= (-region->pitch * (WINDOW_HEIGHT -1));

	#ifdef DEBUG
	printf("==============\n");
	printf("buffer position: %p\n", pixelBuffer);
	for (int i = 0; i < points->num; i++){
		printf("%d: (%d, %d)\n", i, points->x[i], points->y[i]);
	}
	printf("cursor position: %d\n", points->cursor);
	#endif //DEBUG

	if(points->cursor != 0) {
		#ifdef DEBUG
		printf("Drawing...\n");
		#endif
		ret = bezier(pixelBuffer, points->num, points->x, points->y);
	}

	#ifdef DEBUG
	printf("RET: %p\n", ret);
	#endif

	al_unlock_bitmap(bitmap);	
}

void initializeAllegro(){
    if(!al_init()) {
        printf("Error with allegro\n");
		exit(-1);
    }
	al_install_mouse();
	al_init_image_addon();
}
