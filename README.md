# Device_Features_App

# General Description

Pick multiple images app and display them in a list view.

This is a simple application that enables the user to access the device photo library.

**No permission required**:

- We don't need to do anything as this is already handled by the image_picker package.
-----------------------------

# Explanation

The home screen body contains the ListView where the images will be displayed
And the 'pick image' button below the list.

The button pick multiple images using the image picker --> picker.pickMultiImage()
which return List<XFile> images, then i map this list to a list of files and display them in the
list view after calling set setState.

# Note:

While picking images from gallery, some phones like Realme, Oppo, and some OnePlus devices have
issues with pickMultiImage(), as their default gallery app does not fully support multiple selections through
image_picker .
but, while trying any other source of images in the devices like drive or files, the function works
well.

The screen output images --> in the assets/images folder.
Also, The screen output video --> in the assets folder.
----------------------

# Packages Used

Image Picker: => https://pub.dev/packages/image_picker