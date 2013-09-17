

HDrawablePool squarePool;
HColorPool weatherColors;


void setup() {
  size(640,480);
  smooth();
  noLoop();

  // Initialize HYPE
  H.init(this).background(#202020);

  // Draw a weather block.
  // Arguments are startX, startY, sunny, blue, cloudy, rainy
  drawWeatherBlock( (16 + (32*4) * 0), 16, 75, 25,  0,  0);


  H.drawStage();
}

void draw() {

}


/*  drawWeatherBlock draws a four-by-four "block" of weather
    colored squares.
    Pass in the startX and startY of the first square in the block
    keeping in mind, we're anchoring at H.CENTER.

    The other variables set the proportion of weather colors to 
    put in the pool that we'll pick fill colors from. */
    
void drawWeatherBlock ( int myStartX, int myStartY,
                        int sunny, int blue, int cloudy, int rain) {
  // Put some weather-related colors in a pool.
  weatherColors = new HColorPool()
  .add(#FFE800, sunny)  // sunny
  .add(#8FDDF0, blue)  // blue skies
  .add(#CCCCCC, cloudy)  // cloudy
  .add(#333333, rain)  // rain cloudy
  .add(#9E4AFF, 0)  // lavender.  why?  don't know.
  ;

  // Throw sixteen HRects in a pool.  Pool might be useful later.
  squarePool = new HDrawablePool(16)
    .autoAddToStage()
    .add ( 
      new HRect(), 16
    )

    // Apply a grid layout.  Fits thirty-by-thirty squares nicely.
    .layout (
      new HGridLayout()
        .startX(myStartX)
        .startY(myStartY)
        .spacing(32,32)
        .cols(4)
    )

    // Make thirty-by-thirty squares, filled with weatherColors.
    .onCreate (
       new HCallback() {
        public void run(Object obj) {
          HDrawable d = (HDrawable) obj;
          d
            .noStroke()
            .fill( weatherColors.getColor() )
            .anchorAt(H.CENTER)
            .size( 30 )
          ;
        }
      }
    )

    .requestAll()

  ;

}
