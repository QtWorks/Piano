#ifndef PIANO_H
#define PIANO_H

#include <QObject>

class Piano : public QObject {
    Q_OBJECT
public:
    explicit Piano(QObject *parent = nullptr);

signals:
    void sendNote(QString note, QString type);

public slots:
};

#endif // PIANO_H
