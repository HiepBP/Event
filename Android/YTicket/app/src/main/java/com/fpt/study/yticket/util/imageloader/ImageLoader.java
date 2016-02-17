package com.fpt.study.yticket.util.imageloader;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.widget.ImageView;

import com.fpt.study.yticket.R;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collections;
import java.util.Map;
import java.util.WeakHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by Hinaka on 2/17/2016.
 */
public class ImageLoader {
    final int stub_id = R.mipmap.ic_launcher;
    MemoryCache mMemoryCache = new MemoryCache();
    FileCache mFileCache;
    ExecutorService mExecutorService;
    private Map<ImageView, String> mImageViews = Collections.synchronizedMap(new
            WeakHashMap<ImageView, String>());

    public ImageLoader(Context context) {
        mFileCache = new FileCache(context);
        mExecutorService = Executors.newFixedThreadPool(5);
    }

    public void DisplayImage(String url, ImageView imageView) {
        mImageViews.put(imageView, url);
        Bitmap bitmap = mMemoryCache.get(url);
        if (bitmap != null)
            imageView.setImageBitmap(bitmap);
        else {
            queuePhoto(url, imageView);
            imageView.setImageResource(stub_id);
        }
    }

    private void queuePhoto(String url, ImageView imageView) {
        PhotoToLoad p = new PhotoToLoad(url, imageView);
        mExecutorService.submit(new PhotosLoader(p));
    }

    private Bitmap getBitmap(String url) {
        File f = mFileCache.getFile(url);

        //from SD cache
        Bitmap b = decodeFile(f);
        if (b != null)
            return b;

        //from web
        try {
            Bitmap bitmap = null;
            URL imageUrl = new URL(url);
            HttpURLConnection conn = (HttpURLConnection) imageUrl.openConnection();
            conn.setConnectTimeout(30000);
            conn.setReadTimeout(30000);
            conn.setInstanceFollowRedirects(true);
            InputStream is = conn.getInputStream();
            OutputStream os = new FileOutputStream(f);
            ImageUtils.CopyStream(is, os);
            os.close();
            bitmap = decodeFile(f);
            return bitmap;
        } catch (Throwable ex) {
            ex.printStackTrace();
            if (ex instanceof OutOfMemoryError)
                mMemoryCache.clear();
            return null;
        }
    }

    //decodes image and scales it to reduce memory consumption
    private Bitmap decodeFile(File f) {
        try {
            //decode image size
            BitmapFactory.Options o = new BitmapFactory.Options();
            o.inJustDecodeBounds = true;
            BitmapFactory.decodeStream(new FileInputStream(f), null, o);

            //Find the correct scale value. It should be the power of 2.
            final int REQUIRED_SIZE = 600;
            int width_tmp = o.outWidth, height_tmp = o.outHeight;
            int scale = 1;
            while (true) {
                if (width_tmp / 2 < REQUIRED_SIZE || height_tmp / 2 < REQUIRED_SIZE)
                    break;
                width_tmp /= 2;
                height_tmp /= 2;
                scale *= 2;
            }

            //decode with inSampleSize
            BitmapFactory.Options o2 = new BitmapFactory.Options();
            o2.inSampleSize = scale;
            return BitmapFactory.decodeStream(new FileInputStream(f), null, o2);
        } catch (FileNotFoundException e) {
        }
        return null;
    }

    boolean imageViewReused(PhotoToLoad photoToLoad) {
        String tag = mImageViews.get(photoToLoad.imageView);
        if (tag == null || !tag.equals(photoToLoad.url))
            return true;
        return false;
    }

    public void clearCache() {
        mMemoryCache.clear();
        mFileCache.clear();
    }

    //Task for the queue
    private class PhotoToLoad {
        public String url;
        public ImageView imageView;

        public PhotoToLoad(String u, ImageView i) {
            url = u;
            imageView = i;
        }
    }

    class PhotosLoader implements Runnable {
        PhotoToLoad mPhotoToLoad;

        PhotosLoader(PhotoToLoad photoToLoad) {
            this.mPhotoToLoad = photoToLoad;
        }

        @Override
        public void run() {
            if (imageViewReused(mPhotoToLoad))
                return;
            Bitmap bmp = getBitmap(mPhotoToLoad.url);
            mMemoryCache.put(mPhotoToLoad.url, bmp);
            if (imageViewReused(mPhotoToLoad))
                return;
            BitmapDisplayer bd = new BitmapDisplayer(bmp, mPhotoToLoad);
            Activity a = (Activity) mPhotoToLoad.imageView.getContext();
            a.runOnUiThread(bd);
        }
    }

    //Used to display bitmap in the UI thread
    class BitmapDisplayer implements Runnable {
        Bitmap mBitmap;
        PhotoToLoad mPhotoToLoad;

        public BitmapDisplayer(Bitmap b, PhotoToLoad p) {
            mBitmap = b;
            mPhotoToLoad = p;
        }

        public void run() {
            if (imageViewReused(mPhotoToLoad))
                return;
            if (mBitmap != null)
                mPhotoToLoad.imageView.setImageBitmap(mBitmap);
            else
                mPhotoToLoad.imageView.setImageResource(stub_id);
        }
    }

}
