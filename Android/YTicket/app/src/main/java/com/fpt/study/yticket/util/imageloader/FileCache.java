package com.fpt.study.yticket.util.imageloader;

import android.content.Context;

import java.io.File;

/**
 * Created by Hinaka on 2/17/2016.
 */
public class FileCache {
    private File mCacheDir;

    public FileCache(Context context){
        //Find the dir to save cached images
        if (android.os.Environment.getExternalStorageState().equals(android.os.Environment.MEDIA_MOUNTED))
            mCacheDir =new File(android.os.Environment.getExternalStorageDirectory(),"TTImages_cache");
        else
            mCacheDir =context.getCacheDir();
        if(!mCacheDir.exists())
            mCacheDir.mkdirs();
    }

    public File getFile(String url){
        //I identify images by hashcode. Not a perfect solution, good for the demo.
        String filename=String.valueOf(url.hashCode());
        //Another possible solution (thanks to grantland)
        //String filename = URLEncoder.encode(url);
        File f = new File(mCacheDir, filename);
        return f;

    }

    public void clear(){
        File[] files= mCacheDir.listFiles();
        if(files==null)
            return;
        for(File f:files)
            f.delete();
    }
}
