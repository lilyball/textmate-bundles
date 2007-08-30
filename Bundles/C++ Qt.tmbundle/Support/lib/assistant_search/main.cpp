#include <QString>
#include <QFile>
#include <QDataStream>
#include <QDir>
#include <QStringListModel>
#include <QRegExp>

struct ContentItem {
	ContentItem()
		: title( QString() ), reference( QString() ), depth( 0 ) {}
	ContentItem( const QString &t, const QString &r, int d )
		: title( t ), reference( r ), depth( d ) {}
	QString title;
	QString reference;
	int depth;
	Q_DUMMY_COMPARISON_OPERATOR(ContentItem)
};

QDataStream &operator>>(QDataStream &s, ContentItem &ci)
{
	s >> ci.title;
	s >> ci.reference;
	s >> ci.depth;
	return s;
}

QDataStream &operator<<(QDataStream &s, const ContentItem &ci)
{
	s << ci.title;
	s << ci.reference;
	s << ci.depth;
	return s;
}

struct IndexItem {
	IndexItem( const QString &k, const QString &r )
		: keyword( k ), reference( r ) {}
	QString keyword;
	QString reference;
};


struct IndexKeyword {
	IndexKeyword(const QString &kw, const QString &l)
		: keyword(kw), link(l) {}
	IndexKeyword() : keyword(QString()), link(QString()) {}
	bool operator<(const IndexKeyword &ik) const {
		return keyword.toLower() < ik.keyword.toLower();
	}
	bool operator<=(const IndexKeyword &ik) const {
		return keyword.toLower() <= ik.keyword.toLower();
	}
	bool operator>(const IndexKeyword &ik) const {
		return keyword.toLower() > ik.keyword.toLower();
	}
	Q_DUMMY_COMPARISON_OPERATOR(IndexKeyword)
	QString keyword;
	QString link;
};

QDataStream &operator>>(QDataStream &s, IndexKeyword &ik)
{
	s >> ik.keyword;
	s >> ik.link;
	return s;
}

QDataStream &operator<<(QDataStream &s, const IndexKeyword &ik)
{
	s << ik.keyword;
	s << ik.link;
	return s;
}

class IndexListModel: public QStringListModel
{
public:
	IndexListModel(QObject *parent = 0)
		: QStringListModel(parent) {}

	void clear() { contents.clear(); setStringList(QStringList()); }

	QString description(int index) const { return stringList().at(index); }
	QStringList links(int index) const { return contents.values(stringList().at(index)); }
	void addLink(const QString &description, const QString &link) { contents.insert(description, link); }

	void publish() { filter(QString(), QString()); }

	QModelIndex filter(const QString &s, const QString &real);

	virtual Qt::ItemFlags flags(const QModelIndex &index) const
		{ return QStringListModel::flags(index) & ~Qt::ItemIsEditable; }

private:
	QMultiMap<QString, QString> contents;
};

bool caseInsensitiveLessThan(const QString &as, const QString &bs)
{
	const QChar *a = as.unicode();
	const QChar *b = bs.unicode();    
	if (a == 0)
		return true;
	if (b == 0)
		return false;
	if (a == b)
		return false;
	int l=qMin(as.length(),bs.length());
	while (l-- && a->toLower() == b->toLower())
		a++,b++;
	if (l==-1)
		return (as.length() < bs.length());
	return a->toLower().unicode() < b->toLower().unicode();
}

/**
 * \a real is kinda a hack for the smart search, need a way to match a regexp to an item
 * How would you say the best match for Q.*Wiget is QWidget?
 */
QModelIndex IndexListModel::filter(const QString &s, const QString &real)
{
	QStringList list;

	int goodMatch = -1;
	int perfectMatch = -1;
	if (s.isEmpty())
		perfectMatch = 0;

	const QRegExp regExp(s);
	QMultiMap<QString, QString>::iterator it = contents.begin();
	QString lastKey;
	for (; it != contents.end(); ++it) {
		if (it.key() == lastKey)
			continue;
		lastKey = it.key();
		const QString key = it.key();
		if (key.contains(regExp) || key.contains(s, Qt::CaseInsensitive)) {
			list.append(key);
			//qDebug() << regExp << regExp.indexIn(s) << s << key << regExp.matchedLength();
			if (perfectMatch == -1 && (key.startsWith(real, Qt::CaseInsensitive))) {
				if (goodMatch == -1)
					goodMatch = list.count() - 1;
				if (real.length() == key.length())
					perfectMatch = list.count() - 1;
			} else if (perfectMatch > -1 && s == key) {
				perfectMatch = list.count() - 1;
			}
		}
	}

	int bestMatch = perfectMatch;
	if (bestMatch == -1)
		bestMatch = goodMatch;

	bestMatch = qMax(0, bestMatch);

	// sort the new list
	QString match;
	if (bestMatch >= 0 && list.count() > bestMatch)
		match = list[bestMatch];
	qSort(list.begin(), list.end(), caseInsensitiveLessThan);
	setStringList(list);
	for (int i = 0; i < list.size(); ++i) {
		if (list.at(i) == match){
			bestMatch = i;
			break;
		}
	}
	return index(bestMatch, 0, QModelIndex());
}

class AssistantIndex
{
private:
	QString cacheFilesPath;
	IndexListModel *indexModel;
	QModelIndex currentIndex;
	bool _indexLoaded;
	bool fuzzySearch;

	typedef QList<ContentItem> ContentList;
	QList<QPair<QString, ContentList> > contentList;
	QMap<QString, QString> titleMap;

	bool loadIndex()
	{
		QFile indexFile(cacheFilesPath + QDir::separator() + "indexdb40.default");
		if (!indexFile.open(QFile::ReadOnly)) {
			qWarning("Unable to open index file %s", indexFile.fileName().toLatin1().data());
			return false;
		}
	
		QDataStream ds(&indexFile);
		quint32 fileAges;
		ds >> fileAges;
		QList<IndexKeyword> lst;
		ds >> lst;
		indexFile.close();
	
		foreach (IndexKeyword idx, lst)
			indexModel->addLink(idx.keyword, idx.link);
		
		return true;
	}

	bool loadTitles()
	{
		QFile contentFile(cacheFilesPath + QDir::separator() + "contentdb40.default");
		if (!contentFile.open(QFile::ReadOnly)) {
			qWarning("Unable to open content file %s", contentFile.fileName().toLatin1().data());
			return false;
		}

		QDataStream ds(&contentFile);
		quint32 fileAges;
		ds >> fileAges;
		QString key;
		QList<ContentItem> lst;
		while (!ds.atEnd()) {
			ds >> key;
			ds >> lst;
			contentList += qMakePair(key, QList<ContentItem>(lst));
		}
		contentFile.close();

		//titleMapDone = true;
		titleMap.clear();
		for(QList<QPair<QString, ContentList> >::Iterator it = contentList.begin(); it != contentList.end(); ++it) {
			ContentList lst = (*it).second;
			foreach (ContentItem item, lst) {
				titleMap[item.reference] = item.title.trimmed();
			}
		}
		return true;
	}

	QString removeAnchorFromLink(const QString &link)
	{
		int i = link.length();
		int j = link.lastIndexOf('/');
		int l = link.lastIndexOf(QDir::separator());
		if (l > j)
			j = l;
		if (j > -1) {
			QString fileName = link.mid(j+1);
			int k = fileName.lastIndexOf('#');
			if (k > -1)
				i = j + k + 1;
		}
		return link.left(i);
	}

	QString titleOfLink(const QString &link, const QString &description)
	{
		QString s = removeAnchorFromLink(link);
		s = titleMap[s];
		if (s.isEmpty())
			return link;
		
		if (!description.isEmpty())
			s += " (" + description + ")";
		else {
			QString anchor = link.mid(removeAnchorFromLink(link).length() + 1);
			if (anchor.length() > 1)
				s += " (" + anchor + ")";
		}
		return s;
	}

	QModelIndex getCurrentIndex(QString searchString)
	{
		QModelIndex currentIndex;

		QRegExp atoz("[A-Z]");
		int matches = searchString.count(atoz);

		if (matches > 0 && !searchString.contains(".*")) {
			int start = 0;
			QString newSearch;
			for (; matches > 0; --matches) {
				int match = searchString.indexOf(atoz, start+1);
				if (match <= start)
					continue;
				newSearch += searchString.mid(start, match-start);
				newSearch += ".*";
				start = match;
			}
			newSearch += searchString.mid(start);
			currentIndex = indexModel->filter(newSearch, searchString);
		}
		else
			currentIndex = indexModel->filter(searchString, searchString);

		return currentIndex;
	}

	void _displayResults(QStringList linkList, QStringList linkNames)
	{
		for (int i = 0; i < linkList.count(); i++) {
			printf("* %s|%s\n", linkNames[i].toLatin1().data(), linkList[i].toLatin1().data());
		}
	}

public:
	AssistantIndex(bool fuzzy) {
		fuzzySearch = fuzzy;
		cacheFilesPath = QDir::homePath() + QLatin1String("/.assistant");
		indexModel = new IndexListModel;
		_indexLoaded = loadIndex();
		loadTitles();
	}
	
	~AssistantIndex() {
		delete indexModel;
	}
	
	bool indexLoaded() { return _indexLoaded; }
	
	bool search(QString searchString) {
		currentIndex = getCurrentIndex(searchString);
		int row = currentIndex.row();
	    if (row == -1 || row >= indexModel->rowCount()) {
			qWarning("No matches found for query '%s'", searchString.toLatin1().data());
			return false;
		}
		return true;
	}

	void displayResults() {
		QStringList linkList;
		QStringList linkNames;
		
		if (fuzzySearch) {
			for (int i = 0; i < indexModel->stringList().count(); i++) {
				QStringList links = indexModel->links(i);
				foreach (QString link, links) {
					linkList  << link;
					linkNames << titleOfLink(link, indexModel->stringList()[i]);
				}
			}
		}
		else {
			int row = currentIndex.row();
			QString description = indexModel->description(row);
		    QStringList links = indexModel->links(row);

			if (links.count() == 1) {
				linkList  << links.first();
				linkNames << titleOfLink(links.first(), description);
			}
			else {
				qSort(links);
				foreach (QString link, links) {
					linkList  << link;
					linkNames << titleOfLink(link, description);
				}
			}
		}
		_displayResults(linkList, linkNames);
	}
};

int main (int argc, char *argv[])
{
	if (argc < 2) {
		qWarning("USAGE: %s search_string [fuzzy]", argv[0]);
		return 1;
	}
	
	AssistantIndex assistant(argc == 3 && QString(argv[2]) == "fuzzy");
	if (!assistant.indexLoaded())
		return 1;

	if (!assistant.search(argv[1]))
		return 1;
		
	assistant.displayResults();
	return 0;
}