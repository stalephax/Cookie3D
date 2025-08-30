// ImageMapClass.h: interface for the ImageMapClass class.

#if !defined _IMAGEMAPCLASS_H
#define AFX_IMAGEMAPCLASS_H

#include "VectorMath.h"

class ImageMapClass  
{
public:
    int width;             /* hoogte plaatje  */
	int height;            /* breedte plaatje */
	unsigned char *pp;     /* pixels          */
	
	ImageMapClass();
	virtual ~ImageMapClass();

	void Create(int w, int h);
    void LoadTGA(char *filename);
};

#endif // !defined _IMAGEMAPCLASS_H





















