#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QObject>
#include <QDebug>
#include <QtSerialPort/QSerialPortInfo>
#include <QtSerialPort/QSerialPort>
#include <QFile>
#include <QDataStream>
#include <QMidiOut.h>
#include <alsa/asoundlib.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include "OS/aseqdump.cpp"
#include "QMidi.h"
#include "Piano.h"
#include <QMetaObject>
#include <QQmlContext>

int stopp=0;
void sighandlerr(int dum) {
    stopp=1;
}
int main(int argc, char *argv[]) {
//    unsigned char foo=84;
//    qDebug() << QString::number((quint8)foo);
//    qDebug() << QString::number(foo);
//    return 0;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine *engine = new QQmlApplicationEngine();
    Piano *piano = new Piano();
    engine->rootContext()->setContextProperty("$piano", piano);

    engine->load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine->rootObjects().isEmpty())
        return -1;


    QMidi *midi = new QMidi();
    QObject::connect(midi, &QMidi::sendNote, piano, &Piano::sendNote);
    midi->initSequencer();
    midi->listPorts();
    midi->parsePorts();
    midi->createPort();
    midi->connectPorts();
    midi->initialize();
    midi->start();

    //delete midi;
    //    QSerialPortInfo spi;
//    foreach (QSerialPortInfo item, spi.availablePorts()) {
//        qDebug() << item.portName();
//    }

//    int numRead = 0, numReadTotal = 0;
//    char buffer;//[255];




//    signal(SIGINT,sighandlerr);
//    snd_rawmidi_t *handle_in = 0;
//    int err = snd_rawmidi_open(&handle_in, NULL, "hw:1,0,0", 0);
//    if(err) {
//        qDebug() << "Error";
//        return 0;
//    }
//    while(true) {
//        unsigned char ch[1];
//        int ret;
//        while (!stopp) {
//            ret = snd_rawmidi_read(handle_in,&ch,1);
//            if ((ret < 0) && (ret != -EBUSY) && (ret != -EAGAIN)) {
//                fprintf(stderr, "Problem reading MIDI input: %s\n",ret);
//            } else if (ret >= 0) {

//                if ((unsigned char)ch[0] >= 0x80) {  // print command in hex
//                    fprintf(stderr, "0x%x \n", (unsigned char)ch[0]);
//                } else {
//                    fprintf(stderr, "%d \n", (unsigned char)ch[0]);
//                }


//            }


//        }
//    }
//    snd_rawmidi_close(handle_in);
    return app.exec();
}
