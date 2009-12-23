NAME=dokidoki-support

#### General Settings

TARGET=$(NAME)
CFLAGS=-Wall -O2 -DMEMARRAY_USE_OPENGL \
	   $(PLATFORM_CFLAGS) $(EXTRA_CFLAGS)
LDFLAGS= $(STATIC_LINK) -llua -lportaudio -lglfw \
		 $(DYNAMIC_LINK) $(PLATFORM_LDFLAGS) $(EXTRA_LDFLAGS)

#### Platform Settings

linux:
	make $(TARGET) PLATFORM=linux \
		STATIC_LINK="-Wl,-Bstatic" \
		DYNAMIC_LINK="-Wl,-Bdynamic" \
		PLATFORM_CFLAGS="-pthread" \
		PLATFORM_LDFLAGS="-Wl,-E -pthread -lpthread -lGL -lGLU -lX11 -lXrandr -lm -lasound"

macosx:
	make $(TARGET) PLATFORM=macosx \
		STATIC_LINK="" \
		DYNAMIC_LINK="" \
		PLATFORM_CFLAGS="" \
		PLATFORM_LDFLAGS="-Wl,-reexport-llua -framework AGL -framework OpenGL -framework Carbon"

mingw:
	make $(TARGET) PLATFORM=mingw \
		STATIC_LINK="-Wl,-Bstatic" \
		DYNAMIC_LINK="-Wl,-Bdynamic" \
		PLATFORM_CFLAGS="" \
		PLATFORM_LDFLAGS="-Wl,-E -lopengl32 -lglu32 -lole32 -lwinmm"

clean:
	rm -f *.o $(NAME)

#### Actual Building

$(TARGET): minlua.o luaglfw.o lua_stb_image.o mixer.o memarray.o gl.o glu.o
	$(CC) -o $@ $^ $(LDFLAGS)