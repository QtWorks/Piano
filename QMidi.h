#ifndef QMIDI_H
#define QMIDI_H

#include <QObject>
#include <QThread>
#include <QDebug>

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <signal.h>
#include <getopt.h>
#include <sys/poll.h>
#include <alsa/asoundlib.h>
class QMidi : public QThread {
    Q_OBJECT
public:
    QMidi(QObject *parent=Q_NULLPTR);
    void run() Q_DECL_OVERRIDE;
    void initialize();
    void initSequencer();
    void listPorts();
    void parsePorts();
    void createPort();
    void connectPorts();

    void sendEvent(const snd_seq_event_t *ev);
signals:
    void sendNote(QString note, QString type);
private:
    snd_seq_t *seq;
    int port_count=0;
    snd_seq_addr_t *ports;
    volatile sig_atomic_t stop = 0;
    struct pollfd *pfds;
    int npfds;

};

#endif // QMIDI_H
