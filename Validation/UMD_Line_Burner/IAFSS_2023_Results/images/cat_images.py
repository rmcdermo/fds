#!/usr/bin/python3
#McDermott
#2-7-2023
#cat_images.py

from PIL import Image
from mpl_toolkits.axes_grid1 import make_axes_locatable
import matplotlib.pyplot as plt

im1 = Image.open('propane_tri_coarse.png')
im2 = Image.open('propane_tri_medium.png')
im3 = Image.open('propane_tri_fine.png')

def add_margin(pil_img, top, right, bottom, left, color):
    width, height = pil_img.size
    new_width = width + right + left
    new_height = height + top + bottom
    result = Image.new(pil_img.mode, (new_width, new_height), color)
    result.paste(pil_img, (left, top))
    return result

im1_pad = add_margin(im1,2,2,2,2,'white')
im1_pad.save('im1_pad.png')
im2_pad = add_margin(im2,2,2,2,2,'white')
im2_pad.save('im2_pad.png')
im3_pad = add_margin(im3,4,4,4,4,'white')
im3_pad.save('im3_pad.png')

def get_concat_h(im1, im2):
    dst = Image.new('RGB', (im1.width + im2.width, im1.height))
    dst.paste(im1, (0, 0))
    dst.paste(im2, (im1.width, 0))
    return dst

def get_concat_h_resize(im1, im2, resample=Image.BICUBIC, resize_big_image=True):
    if im1.height == im2.height:
        _im1 = im1
        _im2 = im2
    elif (((im1.height > im2.height) and resize_big_image) or
          ((im1.height < im2.height) and not resize_big_image)):
        _im1 = im1.resize((int(im1.width * im2.height / im1.height), im2.height), resample=resample)
        _im2 = im2
    else:
        _im1 = im1
        _im2 = im2.resize((int(im2.width * im1.height / im2.height), im1.height), resample=resample)
    dst = Image.new('RGB', (_im1.width + _im2.width, _im1.height))
    dst.paste(_im1, (0, 0))
    dst.paste(_im2, (_im1.width, 0))
    return dst

im12 = get_concat_h_resize(im1_pad, im2_pad)
im123 = get_concat_h_resize(im12, im3_pad)
im123.save('propane_tri_concat_h.png')

dpi=220
fig = plt.figure(figsize=(im123.width/dpi,im123.height/dpi))

imgplot = plt.imshow(im123)
ax = plt.gca()
plt.tick_params(left = False, right = False , labelleft = False ,
                labelbottom = False, bottom = False)
imgplot.set_cmap('jet')
divider = make_axes_locatable(ax)
cax = divider.append_axes("right", size="3%", pad=0.05)
cbar = plt.colorbar(cax=cax,ticks=[15, 132.5, 250])
cbar.ax.set_yticklabels(['1', '1.5', '2'])
cbar.ax.tick_params(labelsize=16)

plt.tight_layout()
plt.savefig('last_image.pdf')    #saving new image
plt.show()


