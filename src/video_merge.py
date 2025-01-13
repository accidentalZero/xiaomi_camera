from datetime import datetime
import os
from moviepy import VideoFileClip, concatenate_videoclips


PATH = '/home/admin/Рабочий стол/TestVideo' 


def concatenate(source_paths, output_path):
    sub = [os.path.join(source_paths, name) for name in os.listdir(source_paths) if '.mp4' in name]
    clips = [VideoFileClip(c) for c in sub]  
          
    final_clip = concatenate_videoclips(clips, method="compose")
    final_clip.write_videofile(output_path)





hours = ['15', '16', '17']
curr_date = '20191001'  # datetime.today().strftime('%Y%m%d')

target_dirs = [curr_date + hour for hour in hours]
all_subdirs = [name for name in os.listdir(PATH) if os.path.isdir((os.path.join(PATH, name)))]
dirs_to_merge = list(set(all_subdirs) & set(target_dirs))
dirs_to_merge.sort()

concatenate(os.path.join(PATH, dirs_to_merge[0]), '/home/admin/dev/xiaomi_camera/result.mp4')



print(dirs_to_merge)
