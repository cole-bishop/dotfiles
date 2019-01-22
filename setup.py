import os
import re
import glob
import subprocess
import itertools

# def walkabs(top, walk=True, oneerror=None, followLinks=False): 
#     """
#     Same as os.walk(), except it returns single, fully qualified
#     filenames.
#     """
#     for dirpath, _, filenames in os.walk(top, walk, oneerror, followLinks):
#         for filename in filenames:
#             yield dirpath + os.sep + filename

# def ziptuple(root_iterable, link_iterable, link_func):
#     """Yields a tuple for each element in root_iterable
#     with the first match found in link_iterable based on
#     link_func

#     Keyword arguements:
#     root_iterable -- the iterable to link upon (is 'left joined')
#     link_iterable -- the iterable to find matches in
#     link_func -- predicate function that takes two values and returns
#     a boolean if they are to be mapped to one another.
#     """
#     for root_item in root_iterable:
#         for link_item in link_iterable:
#             if link_func(root_item, link_item):
#                 yield (root_item, link_item)
#                 break

# def is_dotfile(abspath):
#     try:
#         # Absolute path split on path segment - access last element (filename)
#         # then first character of final segment. Should be '.' if dotfile.
#         return str(abspath).split(os.sep)[-1][0] == '.' 
#     except:
#         return False

# First element in os.walk() is the distro directory
dotfiles_top_dir = os.getcwd()
distro_dir = itertools.islice(os.walk(os.path.join(os.getcwd(), 'distros')), 1)
distros_parent_dir, available_distros = [ (dirpath, dirnames) for dirpath, dirnames, filenames in distro_dir ][0]

# Ask for user desired distro
prompt = "The following distro setups were detected:" \
         "\n{distros}\nSelect one of the above to setup for: " \
         .format(distros="\n".join(available_distros))

distro = input(prompt)

# Reprompt if not an available option.
while distro not in available_distros:
    distro = input(prompt)

# Get ditro and common dotfile related directories.
common_dotfiles_dir = os.path.join(os.getcwd(), 'common')
selected_distro_dir = os.path.join(os.getcwd(), 'distros', distro)

common_dotfile_process = subprocess.Popen(args=['stow', f'--target={os.environ["HOME"]}', 'common', '-v 4'], \
                                          stdout=subprocess.PIPE, \
                                          stderr=subprocess.PIPE, \
                                          cwd=dotfiles_top_dir)

distro_dotfile_process = subprocess.Popen(args=['stow', f'--target={os.environ["HOME"]}', distro, '-v 4'], \
                                          stdout=subprocess.PIPE, \
                                          stderr=subprocess.PIPE, \
                                          cwd=distros_parent_dir)

common_stdout, common_stderr = common_dotfile_process.communicate()
distro_stdout, distro_stderr = distro_dotfile_process.communicate()

print("\n".join(['Stowing common files...', common_stdout, common_stderr]))
print("\n".join([f'Stowing {distro} files...', distro_stdout, distro_stderr]))
# common_dotfiles = list(filter(is_dotfile, walkabs(common_dotfiles_dir)))
# distro_dotfiles = list(filter(is_dotfile, walkabs(distro_dotfiles_dir)))



# Predicate to tell if the common dotfile is the pair for the given distro dotfile
# is_matching_dotfile = lambda common_dotfile, distro_dotfile: f'{os.path.split(common_dotfile)[1]}_common.sh' == os.path.split(distro_dotfile)[1]

# coupled_dotfiles = ziptuple(distro_dotfiles, common_dotfiles, is_matching_dotfile)


# for distro_dotfile, common_dotfile in coupled_dotfiles:
#     print(f'{common_dotfile} : {distro_dotfile}' + "\n")
    # execution_dir = distro_dotfile if distro_dotfile else common_dotfile
    # process = subprocess.Popen(args=['ls'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=execution_dir)
    # stdout, stderr = process.communicate()
    # if stderr:
    #      print(stderr.decode('utf-8'))