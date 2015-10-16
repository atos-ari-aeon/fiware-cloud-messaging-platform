![Logo](http://130.206.81.70:3000/public/doc/source/images/web_header_medium.png)

# Contents

- [Description](#description)
- [Benefits](#benefits)
- [Technical Description](#technical-description)
- [API Reference](#api-reference)
- [License](#license)

# Description

This document describes AEON as a cloud platform to create applications
with real time communications channels. The architecture is based on the
strongly communication needs that we need to face nowadays, with
billions of interconnected devices and short times of response. Thus,
the technological solutions used for the implementation are based on
strong requirements about: performance, response and scalability, making
use of the most advanced cutting edge technologies.

Due the interoperability needs of these architectures, AEON has been
fully designed considering Free Libre Open Source Software technologies.
The project has been designed and implemented by the “Supply Chain
Sector in the Research & Innovation department in ATOS Spain”.

AEON aims to facilitate real time communication. It borns from the
strong need to be (always) interconnected, whether personal reasons or
business needs. We are constantly exchanging information trough
different applications: emails, instant messaging, location, etc, not
caring about the amount of information or the receptor’s location. These
applications are supported by a communication network, but, which
infrastructure is being used? Who is the owner? What if I have similar
communication needs than WhatsApp?

> **note**

> AEON facilitates to create and manage communications channels. Later,
> these channels will support the development of application with real
> time requirements for communications.

What does real time communications means?
=========================================

What does “Real Time Communication Infrastructure” means? In our current
technological stage, the amount of information that it is going to be
created during the [next five minutes][] , in the computing world, is
almost impossible to be calculated: Facebook generates [2.5B likes by
day][] , FourSquare receives [5M checking][] (user’s locations) each
day. This situation converges to the need of new infrastructures where
it has no limits about gathering (web services), storing (cloud
distributed storage) data, and faster communication channels
(event-driven architectures). From a more functional point of view:
“Cloud infrastructures which spread web services over the unlimited
network, capable of processing millions of request by second, and
communications with just a few milliseconds of delay”.

How does AEON work?
===================

AEON provides cloud services (channels) to communicate an unlimited
number of entities, interchanging an unlimited amount of information.
But it is not only about the communication, it also provides services
for easily management of entities participating in your environments:
mobile, truck, box, thermometer, even yourself…).

![An interconnected world thanks to AEON](http://130.206.81.70:3000/public/doc/source/images/AEON-basic3.png)

In this figure, the upper left ship is “virtualized” into AEON as a
new entity with a communication channel. We consider an entity as
anything that can participate communicating information. With cloud
message queuing, the subscriber to a service does not need to understand
the protocol used by the service provider or vice versa but can focus on
requesting the required business functionality. AEON platform offers a
shared cloud-based message queuing framework enabling messaging between
various entities that wish to communicate with each other seamlessly and
reliably using standard vendor neutral protocols


# Benefits 
 * Communicate applications and services through a real time network
 * Easy to use, easy to integrate in developments: AEON provides an SDK to connect your services and devices over a globally scaled real-time network
 *	Performance, Scalability and Reliability: High performance for message delivery and data exchange between business processes and devices and from device to device. AEON is able to handle multiple types and priorities of messages, whilst at the same time providing the necessary Quality of Service. AEON provides reliable messaging with durability and persistence and needs to scale well for extremely large volumes.
 *	Big Data: AEON can take care of the cloud messaging of the data capture from M2M environments and big data flows.

# Technical description

Online thecnical documentation can be [find here](http://130.206.81.70:3000/public/doc/html/apidoc/apidoc.html). If you are a developer and you are willing to beging coding with AEON, it would be better if you visit the [QuickStart guide](http://130.206.81.70:3000/public/doc/html/apidoc/apidoc.html#quick-start).
 
It is possible to check the "Installation & Admin Manual" and "Users & Programmers Manual" in the next links:

- [Installation & Admin Manual](FIWARE-Cloud-Messaging---Installation-and-Administration-Guide.markdown)
- [User & Programmers Manual](FIWARE-Cloud-Messaging---User-and-Programmers-Guide.markdown)

# API Reference

[Cloud Messaging GE API reference](http://docs.aeon.apiary.io/)

# License

Due the interoperability needs of these architectures, AEON has been fully
designed considering Free Libre Open Source Software technologies. 
The project has been designed and implemented by the Transport and Trade  Logistics Sector in the Research & Innovation department in ATOS Spain.

AEON Platform is released as Open Source.

This project is part of [FIWARE](http://www.fiware.org).

# Support

For any related issue, you can find us [here](mailto:aeon-support@lists.atosresearch.eu)

[Top](#contents)
