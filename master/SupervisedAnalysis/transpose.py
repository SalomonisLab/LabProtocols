import sys, string, export

def transposeMatrix(inputfile):
    print "input"
    print inputfile
    arrays=[]
    filename=inputfile[:-4]+'-transposed.txt'
    filename = string.replace(filename,'//','/')
    filename = string.replace(filename,'\\','/')
    dir = findParentDir(filename)
    try: file_var = createExportFile(filename,dir)
    except RuntimeError:
        isFileOpen(filename,dir)
        file_var = createExportFile(filename,dir)

    #eo = export.ExportFile(Matrix[:-4]+'-transposed.txt')
    for line in open(input_file,'rU').xreadlines():
        data = cleanUpLine(line)
        values = string.split(data,'\t')
        arrays.append(values)
    t_arrays = zip(*arrays)
    for t in t_arrays:
        eo.write(string.join(t,'\t')+'\n')
    eo.close()

def createExportFile(new_file,dir):
    try:
        #isFileOpen(new_file,dir)  ###Creates problems on Mac - not clear why
        fn=filepath(new_file)
        file_var = open(fn,mode)
    except Exception:
        dir = string.replace(dir,'//','/')
        dir = string.replace(dir,'\\','/')
        dir = string.replace(dir,'\\','/')
        dir = filepath(dir)
        dir_ls = string.split(dir,'/')
        i = 1; paths_added = 'no'
        while i <= len(dir_ls):
            new_dir = string.join(dir_ls[:i],'/')
            status = verifyDirectory(new_dir)
            if status == 'no':
                try: os.mkdir(new_dir); paths_added = 'yes'
                except Exception: paths_added = 'yes'
            i+=1
        if paths_added == 'yes':
            try:
                fn=filepath(new_file)
                file_var = open(fn,mode)
            except Exception:
                print "Parent directory not found locally for", [dir,new_file]
        fn=filepath(new_file)
        file_var = open(fn,mode)
    return file_var

def findParentDir(filename):
    ### :: reverses string
    filename = string.replace(filename,'//','/')
    filename = string.replace(filename,'//','/') ### If /// present
    filename = string.replace(filename,'\\','/')
    x = string.find(filename[::-1],'/')*-1 ### get just the parent directory
    return filename[:x]
    
if __name__ == '__main__':
    import getopt
    options, remainder = getopt.getopt(sys.argv[1:],'', ['groups'])
    for opt, arg in options:
        if opt == '--groups': filename=arg
transposeMatrix(filename)