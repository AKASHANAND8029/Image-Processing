#installing magick package from CRAN
#magick lets you print/display image
#in RStudio Viewer pane.
install.packages("magick")
library(magick)

#install.packages("imager")
#library(imager)
#reading a jpeg image
a<- image_read('Sem-6/IMAGE.jpeg')
plot(a)
image_charcoal(a)


out1 <- image_blur(a, 3)
out1
out2 <- image_oilpaint(a, 3)
out2

#image_compare calculates a metric by comparing image with a reference image

input <- c(a, out1, out2, a)
if(magick_config()$version >= "6.8.7"){
  diff_img <- image_compare(input, a, metric = "AE")
  attributes(diff_img)
}
#image:  magick image object returned by image_read() or image_graph()
#fps:  frames per second. Ignored if delay is not NULL.
#delay:  delay after each frame, in 1/100 seconds. Must be length 1, or number of frames.
#If specified, then fps is ignored.
#loop:  how many times to repeat the animation. Default is infinite.
#dispose:  a frame disposal method from dispose_types()
#optimize:  optimize the gif animation by storing only the differences between frames. Input images must be exactly the same size.
#frames:  number of frames to use in output animation
#operator:  string with a composite operator from compose_types()
#stack: place images top-to-bottom (TRUE) or left-to-right (FALSE)

#. image_animate coalesces frames by playing the sequence and converting to gif format.
#. image_morph expands number of frames by interpolating intermediate frames to blend into
#each other when played as an animation.
#. image_mosaic inlays images to form a single coherent picture.
#. image_montage creates a composite image by combining frames.
#. image_flatten merges frames as layers into a single frame using a given operator.
#. image_average averages frames into single frame.
#. image_append stack images left-to-right (default) or top-to-bottom
image_animate(a, fps = 10,
              delay = NULL,
              loop = 0,
              dispose = c("background", "previous", "none"),
              optimize = FALSE
)
image_morph(a, frames = 8)
image_mosaic(a, operator = NULL)
image_flatten(a, operator = NULL)
image_average(a)
image_append(a, stack = FALSE)

image_montage(
  a,
  geometry = NULL,
  tile = NULL,
  gravity = "Center",
  bg = "white",
  shadow = FALSE
)

b<- image_read('Sem-6/img.jpeg')
plot(b)

# Combine images

a<- image_read('Sem-6/IMAGE.jpeg')
b<- image_read('Sem-6/img.jpeg')
# Create morphing animation
both <- image_scale(c(b,a), "400")
image_average(image_crop(both))
image_animate(image_morph(both, 10))


# Create thumbnails from GIF
thumb <- image_read('Sem-6/IMAGE.jpeg')
length(a)
image_average(a)
image_flatten(a)
image_append(a)
image_append(a, stack = TRUE)


# Append images together
forest <- image_read('Sem-6/img.jpeg')
#image_append(image_scale(c(image_append(thumb[c(1,3)], stack = TRUE), forest)))
image_composite(thumb, image_scale(a, "300"))
# Break down and combine frames
front <- image_scale(a, "300")
background <- image_background(image_scale(b, "400"), 'blue')
frames <- image_apply(front, function(x){image_composite(background, x, offset = "+70+30")})
image_animate(frames, fps = 10)
# Simple 4x3 montage
input <- rep(a, 12)
image_montage(input, geometry = 'x100+10+10', tile = '4x3', bg = 'pink', shadow = TRUE)
# With varying frame size
input <- c(forest, a, forest, a)
image_montage(input, tile = '2x2', bg = 'pink', gravity = 'southwest')



#brightness:  modulation of brightness as percentage of the current value (100 for no change)
#saturation : modulation of saturation as percentage of the current value (100 for no change)
#hue modulation of hue is an absolute rotation of -180 degrees to +180 degrees from
#the current position corresponding to an argument range of 0 to 200 (100 for no
                                                                    # change)
#max preferred number of colors in the image. The actual number of colors in the
#image may be less than your request, but never more.
#colorspace string with a colorspace from colorspace_types for example "gray", "rgb" or
#"cmyk"
#dither a boolean (defaults to TRUE) specifying whether to apply Floyd/Steinberg error
#diffusion to the image: averages intensities of several neighboring pixels
#treedepth depth of the quantization color classification tree. Values of 0 or 1 allow selection of the optimal tree depth for the color reduction algorithm. Values between
#2 and 8 may be used to manually adjust the tree depth.
#map reference image to map colors from
#threshold_map A string giving the dithering pattern to use. See the ImageMagick documentation for possible values
#channel a string with a channel from channel_types for example "alpha" or "hue" or
#"cyan"
#color a valid color string such as "navyblue" or "#000080". Use "none" for transparency.
#fuzz relative color distance (value between 0 and 100) to be considered similar in the
#filling algorithm
#flatten should image be flattened before writing? This also replaces transparency with
#background color.
#opacity percentage of opacity used for coloring
#sharpen enhance intensity differences in image
#radius replace each pixel with the median color in a circular neighborhood

#image_modulate adjusts brightness, saturation and hue of image relative to current.
#. image_quantize reduces number of unique colors in the image.
#. image_ordered_dither reduces number of unique colors using a dithering threshold map.
#. image_map replaces colors of image with the closest color from a reference image.
#. image_channel extracts a single channel from an image and returns as grayscale.
#. image_transparent sets pixels approximately matching given color to transparent.
#. image_background sets background color. When image is flattened, transparent pixels get
#background color.
#. image_colorize overlays a solid color frame using specified opacity.
#. image_contrast enhances intensity differences in image
#. image_normalize increases contrast by normalizing the pixel values to span the full range of
#colors
#. image_enhance tries to minimize noise
#. image_equalize equalizes using histogram equalization
#. image_median replaces each pixel with the median color in a circular neighborhood
image_modulate(a, brightness = 100, saturation = 100, hue = 100)
image_quantize(
  a,
  max = 256,
  colorspace = "rgb",
  dither = TRUE,
  treedepth = NULL
)
r<-image_map(a, b, dither = FALSE)
r
image_ordered_dither(a, threshold_map)
image_channel(a, channel = "lightness")
image_separate(a, channel = "default")
image_combine(a, colorspace = "sRGB", channel = "default")
image_transparent(a, color, fuzz = 0)
image_background(a, color, flatten = TRUE)
image_colorize(a, opacity, color)
image_contrast(a, sharpen = 1)
image_normalize(a)
image_enhance(a)
image_equalize(a)
image_median(a, radius = 1)
# Specify a text at a point
x<- image_read('Sem-6/img.jpeg')
image_annotate(x, "Confidential", location = geometry_point(100, 200), size = 54, color = 'white')



