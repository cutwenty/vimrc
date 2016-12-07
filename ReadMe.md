# vimrc

这是我在 mac 上 vim 的配置文件，不知道在 linux 上会不会有问题。

## 安装 vundle 插件

很简单，直接在控制台中运行：
	
		git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

## 根据配置安装插件

1. 将所有内容拷到用户主目录下（/Users/yourname）
2. 在控制台中运行 vim，执行：
		
		:PluginInstall
		
3. 接下来，等待安装就行
4. 其中，youcomplete 装上了很卡，自己看着办，不知道是配置哪里有问题，还是我 macbook 配置差。要取消 youcomplete 的安装，只要打开 .vimrc.bundles 将 Bundle "Valloric/YouCompleteMe" 注释，再执行第二步就行。